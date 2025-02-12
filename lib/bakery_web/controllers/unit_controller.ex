defmodule BakeryWeb.UnitController do
  use BakeryWeb, :controller

  alias Bakery.Units

  def index(conn, _params) do
    user = conn.assigns.current_user
    units = Units.list_units(user.tenant)
    render(conn, :index, units: units)
  end
end
