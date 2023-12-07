defmodule Ukio.BookingFixtures do
  alias Ukio.ApartmentFixtures
  def booking_fixture(attrs \\ %{}) do
    apartment = ApartmentFixtures.apartment_fixture_earth()

    {:ok, booking} =
      attrs
      |> Enum.into(%{
        apartment_id: apartment.id,
        check_in: ~D[2023-03-26],
        check_out: ~D[2023-03-26],
        deposit: 100_000,
        monthly_rent: apartment.monthly_price,
        utilities: 20000
      })
      |> Ukio.Repositories.BookingRepository.create_booking()

    booking
  end
end