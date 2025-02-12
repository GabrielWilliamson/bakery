defmodule BakeryWeb.ConvertionControllerTest do
  use BakeryWeb.ConnCase

  import Bakery.ConvertionsFixtures

  @create_attrs %{conversion_factor: "120.5"}
  @update_attrs %{conversion_factor: "456.7"}
  @invalid_attrs %{conversion_factor: nil}

  describe "index" do
    test "lists all convertions", %{conn: conn} do
      conn = get(conn, ~p"/convertions")
      assert html_response(conn, 200) =~ "Listing Convertions"
    end
  end

  describe "new convertion" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/convertions/new")
      assert html_response(conn, 200) =~ "New Convertion"
    end
  end

  describe "create convertion" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/convertions", convertion: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/convertions/#{id}"

      conn = get(conn, ~p"/convertions/#{id}")
      assert html_response(conn, 200) =~ "Convertion #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/convertions", convertion: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Convertion"
    end
  end

  describe "edit convertion" do
    setup [:create_convertion]

    test "renders form for editing chosen convertion", %{conn: conn, convertion: convertion} do
      conn = get(conn, ~p"/convertions/#{convertion}/edit")
      assert html_response(conn, 200) =~ "Edit Convertion"
    end
  end

  describe "update convertion" do
    setup [:create_convertion]

    test "redirects when data is valid", %{conn: conn, convertion: convertion} do
      conn = put(conn, ~p"/convertions/#{convertion}", convertion: @update_attrs)
      assert redirected_to(conn) == ~p"/convertions/#{convertion}"

      conn = get(conn, ~p"/convertions/#{convertion}")
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, convertion: convertion} do
      conn = put(conn, ~p"/convertions/#{convertion}", convertion: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Convertion"
    end
  end

  describe "delete convertion" do
    setup [:create_convertion]

    test "deletes chosen convertion", %{conn: conn, convertion: convertion} do
      conn = delete(conn, ~p"/convertions/#{convertion}")
      assert redirected_to(conn) == ~p"/convertions"

      assert_error_sent 404, fn ->
        get(conn, ~p"/convertions/#{convertion}")
      end
    end
  end

  defp create_convertion(_) do
    convertion = convertion_fixture()
    %{convertion: convertion}
  end
end
