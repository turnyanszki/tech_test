defmodule Ukio.ApartmentTest do
  use Ukio.DataCase

  alias Ukio.Repositories.ApartmentRepository

  describe "apartments" do
    alias Ukio.Entities.Apartment

    import Ukio.ApartmentFixtures

    @invalid_attrs %{
      address: nil,
      monthly_price: nil,
      name: nil,
      square_meters: nil,
      zip_code: nil
    }

    test "list_apartments/0 returns all apartments" do
      apartment_fixture()
      assert length(ApartmentRepository.list_apartments()) == 1
    end

    test "get_apartment!/1 returns the apartment with given id" do
      apartment = apartment_fixture()
      assert ApartmentRepository.get_apartment!(apartment.id) == apartment
    end

    test "create_apartment/1 with valid data creates a apartment" do
      valid_attrs = %{
        address: "some address",
        monthly_price: 42,
        name: "some name",
        square_meters: 42,
        zip_code: "some zip_code"
      }

      assert {:ok, %Apartment{} = apartment} = ApartmentRepository.create_apartment(valid_attrs)
      assert apartment.address == "some address"
      assert apartment.monthly_price == 42
      assert apartment.name == "some name"
      assert apartment.square_meters == 42
      assert apartment.zip_code == "some zip_code"
    end

    test "create_apartment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ApartmentRepository.create_apartment(@invalid_attrs)
    end

    test "update_apartment/2 with valid data updates the apartment" do
      apartment = apartment_fixture()

      update_attrs = %{
        address: "some updated address",
        monthly_price: 43,
        name: "some updated name",
        square_meters: 43,
        zip_code: "some updated zip_code"
      }

      assert {:ok, %Apartment{} = apartment} =
               ApartmentRepository.update_apartment(apartment, update_attrs)

      assert apartment.address == "some updated address"
      assert apartment.monthly_price == 43
      assert apartment.name == "some updated name"
      assert apartment.square_meters == 43
      assert apartment.zip_code == "some updated zip_code"
    end

    test "update_apartment/2 with invalid data returns error changeset" do
      apartment = apartment_fixture()
      assert {:error, %Ecto.Changeset{}} = ApartmentRepository.update_apartment(apartment, @invalid_attrs)
      assert apartment == ApartmentRepository.get_apartment!(apartment.id)
    end

    test "delete_apartment/1 deletes the apartment" do
      apartment = apartment_fixture()
      assert {:ok, %Apartment{}} = ApartmentRepository.delete_apartment(apartment)
      assert_raise Ecto.NoResultsError, fn -> ApartmentRepository.get_apartment!(apartment.id) end
    end

    test "change_apartment/1 returns a apartment changeset" do
      apartment = apartment_fixture()
      assert %Ecto.Changeset{} = ApartmentRepository.change_apartment(apartment)
    end
  end
end
