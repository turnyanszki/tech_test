defmodule Ukio.Services.BookingService do
  alias Ukio.Repositories.ApartmentRepository
  alias Ukio.Repositories.BookingRepository

  def create(
        %{"check_in" => check_in, "check_out" => check_out, "apartment_id" => apartment_id} =
          params
      ) when
        not is_nil(apartment_id) and
        not is_nil(check_in) and
        not is_nil(check_out)
       do
    with a <- ApartmentRepository.get_apartment!(apartment_id),
         {:ok,_} <-  BookingRepository.date_overlap(apartment_id,check_in, check_out),
         b <- generate_booking_data(a, check_in, check_out) do
      BookingRepository.create_booking(b)
    else
      {401, _} -> 401
      _ -> {:error, :unexpected}
    end
  end

  def create(_), do: {:error, :unexpected}

  defp generate_booking_data(apartment, check_in, check_out) do
    basic_data = %{
      apartment_id: apartment.id,
      check_in: check_in,
      check_out: check_out,
      monthly_rent: apartment.monthly_price
    }
    case apartment.market do
    :mars -> Map.merge(basic_data, %{deposit: apartment.monthly_price, utilities: apartment.square_meters * 100})
    _ -> Map.merge(basic_data, %{deposit: 100_000, utilities: 20_000})
    end
  end
end
