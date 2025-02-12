defmodule BakeryWeb.ConvertionController do
  use BakeryWeb, :controller

  alias Bakery.Convertions

  def show(conn, %{"id" => id}) do
    convertion = Convertions.get_convertion!(id)
    render(conn, :show, convertion: convertion)
  end
end
