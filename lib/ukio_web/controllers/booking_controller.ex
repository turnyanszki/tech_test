defmodule UkioWeb.BookingController do
  use UkioWeb, :controller
  use PhoenixSwagger

  require Logger

  alias Ukio.Services.BookingService
  alias Ukio.Entities.Booking
  alias Ukio.Repositories.BookingRepository

  action_fallback UkioWeb.FallbackController

  swagger_path :index do
    get "/bookings"
    description "List of bookings"
    response 200, "Success", :Bookings
  end

  def swagger_definitions do
  %{
    Booking: swagger_schema do
      title "Booking"
      description "Booking"
      properties do
            id :integer
            check_in :string, "check in" ,format: :datetime
            check_out :string, "check out" ,format: :datetime
            deposit :integer
            monthly_rent :integer
            utilities :integer
      end
    end,
    Bookings: swagger_schema do
      title "Bookings"
      description "A collection of Bookings"
      type :array
      items Schema.ref(:Booking)
    end
  }
  end


def create(conn, %{"booking" => booking_params}) do
  case BookingService.create(booking_params) do
    {:ok, %Booking{} = booking} ->
      conn
      |> put_status(201)
      |> put_view(UkioWeb.JsonRenderers.BookingJSON)
      |> render(:show, booking: booking)
     401 ->
      conn
      |> put_status(401)
      |> put_view(UkioWeb.JsonRenderers.ErrorJSON)
      |> render("401.json")
    _ ->
      conn
      |> put_status(500)
      |> put_view(UkioWeb.JsonRenderers.ErrorJSON)
      |> render("500.json")
  end
end

  def show(conn, %{"id" => id}) do
    booking = BookingRepository.get_booking!(id)
    conn
    |> put_view(UkioWeb.JsonRenderers.BookingJSON)
    |> render(:show, booking: booking)
  end

  def index(conn, _params) do
    bookings = BookingRepository.list_bookings()
    conn
    |> put_view(UkioWeb.JsonRenderers.BookingJSON)
    |> render(:index, bookings: bookings)
  end
end
