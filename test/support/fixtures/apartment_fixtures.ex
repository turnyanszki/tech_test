defmodule Ukio.ApartmentFixtures do
  def apartment_fixture_earth(attrs \\ %{}) do
    {:ok, apartment} =
      attrs
      |> Enum.into(%{
        address: "some address",
        monthly_price: 250_000,
        name: "some name",
        square_meters: 42,
        zip_code: "some zip_code",
        market: :earth
      })
      |> Ukio.Repositories.ApartmentRepository.create_apartment()

    apartment
  end
  def apartment_fixture_mars(attrs \\ %{}) do
    {:ok, apartment} =
      attrs
      |> Enum.into(%{
        address: "some address",
        monthly_price: 250_000,
        name: "some name",
        square_meters: 42,
        zip_code: "some zip_code",
        market: :mars
      })
      |> Ukio.Repositories.ApartmentRepository.create_apartment()

    apartment
  end
end
