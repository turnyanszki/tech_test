defmodule UkioWeb.ApartmentController do
  use UkioWeb, :controller
  use PhoenixSwagger

  alias Ukio.Repositories.ApartmentRepository

  action_fallback UkioWeb.FallbackController

  swagger_path :index do
    get "/apartments"
    description "List of apartments"
    response 200, "Success", :Apartments
  end

  def swagger_definitions do
  %{
    Apartment: swagger_schema do
      title "Apartment"
      description "Apartment"
      properties do
            id :integer
            address :string
            monthly_price :integer
            name :string
            square_meters :integer
            zip_code :string
      end
    end,
    Apartments: swagger_schema do
      title "Apartments"
      description "A collection of Apartments"
      type :array
      items Schema.ref(:Apartment)
    end
  }
  end

  def index(conn, _params) do
    apartments = ApartmentRepository.list_apartments()
    render(conn, :index, apartments: apartments)
  end
end
