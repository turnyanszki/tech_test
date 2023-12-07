defmodule Ukio.Services.BookingService do
  alias Ukio.Repositories.ApartmentRepository
  alias Ukio.Repositories.BookingRepository

  def create(
        %{"check_in" => check_in, "check_out" => check_out, "apartment_id" => apartment_id} =
          params
      ) do
    with a <- ApartmentRepository.get_apartment!(apartment_id),
         {:ok,_} <-  BookingRepository.date_overlap(apartment_id,check_in, check_out),
         b <- generate_booking_data(a, check_in, check_out) do
      BookingRepository.create_booking(b)
    else
      {401, _} -> 401
      _ -> {:error, :unexpected}
    end
  end

  defp generate_booking_data(apartment, check_in, check_out) do
    %{
      apartment_id: apartment.id,
      check_in: check_in,
      check_out: check_out,
      monthly_rent: apartment.monthly_price,
      utilities: 20_000,
      deposit: 100_000
    }
  end
end
