defmodule Ukio.BookingTest do
  use Ukio.DataCase

  alias Ukio.Repositories.BookingRepository

  describe "bookings" do
    alias Ukio.Entities.Booking

    import Ukio.BookingFixtures
    import Ukio.ApartmentFixtures


    @invalid_attrs %{
      apartment_id: nil,
      check_in: nil,
      check_out: nil,
      deposit: nil,
      monthly_rent: nil,
      utilities: nil
    }
    setup do
      %{apartment: apartment_fixture()}
    end

    test "list_bookings/0 returns all bookings" do
      booking = booking_fixture()
      assert BookingRepository.list_bookings() == [booking]
    end

    test "get_booking!/1 returns the booking with given id" do
      booking = booking_fixture()
      assert BookingRepository.get_booking!(booking.id) == booking
    end

    test "create_booking/1 with valid data creates a booking", %{apartment: apartment} do
      valid_attrs = %{
        apartment_id: apartment.id,
        check_in: ~D[2023-03-26],
        check_out: ~D[2023-03-26],
        deposit: 100_000,
        monthly_rent: 250_000,
        utilities: 20000
      }

      assert {:ok, %Booking{} = booking} = BookingRepository.create_booking(valid_attrs)
      assert booking.apartment_id == apartment.id
      assert booking.check_in == ~D[2023-03-26]
      assert booking.check_out == ~D[2023-03-26]
      assert booking.deposit == 100_000
      assert booking.monthly_rent == 250_000
      assert booking.utilities == 20000
    end

    test "create_booking/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BookingRepository.create_booking(@invalid_attrs)
    end

    test "update_booking/2 with valid data updates the booking" do
      booking = booking_fixture()

      update_attrs = %{
        check_in: ~D[2023-03-27],
        check_out: ~D[2023-03-27]
      }

      assert {:ok, %Booking{} = booking} = BookingRepository.update_booking(booking, update_attrs)
      assert booking.check_in == ~D[2023-03-27]
      assert booking.check_out == ~D[2023-03-27]
    end

    test "update_booking/2 with invalid data returns error changeset" do
      booking = booking_fixture()
      assert {:error, %Ecto.Changeset{}} = BookingRepository.update_booking(booking, @invalid_attrs)
      assert booking == BookingRepository.get_booking!(booking.id)
    end

    test "delete_booking/1 deletes the booking" do
      booking = booking_fixture()
      assert {:ok, %Booking{}} = BookingRepository.delete_booking(booking)
      assert_raise Ecto.NoResultsError, fn -> BookingRepository.get_booking!(booking.id) end
    end

    test "change_booking/1 returns a booking changeset" do
      booking = booking_fixture()
      assert %Ecto.Changeset{} = BookingRepository.change_booking(booking)
    end
  end
end
