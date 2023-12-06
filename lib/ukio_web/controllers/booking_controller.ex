defmodule UkioWeb.BookingController do
  use UkioWeb, :controller
  use PhoenixSwagger

  alias Ukio.Services.BookingService
  alias Ukio.Entities.Booking
  alias Ukio.Bookings.Handlers.BookingCreator

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
    with {:ok, %Booking{} = booking} <- BookingCreator.create(booking_params) do
      conn
      |> put_status(:created)
      |> render(:show, booking: booking)
    end
  end

  def show(conn, %{"id" => id}) do
    booking = BookingService.get_booking!(id)
    render(conn, :show, booking: booking)
  end

  def index(conn, _params) do
    bookings = BookingService.list_bookings()
    render(conn, :index, bookings: bookings)
  end
end
