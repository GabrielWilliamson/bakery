defmodule BakeryWeb.UnitControllerTest do
  use BakeryWeb.ConnCase

  import Bakery.UnitsFixtures

  @create_attrs %{name: "some name", short: "some short"}
  @update_attrs %{name: "some updated name", short: "some updated short"}
  @invalid_attrs %{name: nil, short: nil}

  describe "index" do
    test "lists all units", %{conn: conn} do
      conn = get(conn, ~p"/units")
      assert html_response(conn, 200) =~ "Listing Units"
    end
  end

  describe "new unit" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/units/new")
      assert html_response(conn, 200) =~ "New Unit"
    end
  end

  describe "create unit" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/units", unit: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/units/#{id}"

      conn = get(conn, ~p"/units/#{id}")
      assert html_response(conn, 200) =~ "Unit #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/units", unit: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Unit"
    end
  end

  describe "edit unit" do
    setup [:create_unit]

    test "renders form for editing chosen unit", %{conn: conn, unit: unit} do
      conn = get(conn, ~p"/units/#{unit}/edit")
      assert html_response(conn, 200) =~ "Edit Unit"
    end
  end

  describe "update unit" do
    setup [:create_unit]

    test "redirects when data is valid", %{conn: conn, unit: unit} do
      conn = put(conn, ~p"/units/#{unit}", unit: @update_attrs)
      assert redirected_to(conn) == ~p"/units/#{unit}"

      conn = get(conn, ~p"/units/#{unit}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, unit: unit} do
      conn = put(conn, ~p"/units/#{unit}", unit: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Unit"
    end
  end

  describe "delete unit" do
    setup [:create_unit]

    test "deletes chosen unit", %{conn: conn, unit: unit} do
      conn = delete(conn, ~p"/units/#{unit}")
      assert redirected_to(conn) == ~p"/units"

      assert_error_sent 404, fn ->
        get(conn, ~p"/units/#{unit}")
      end
    end
  end

  defp create_unit(_) do
    unit = unit_fixture()
    %{unit: unit}
  end
end
