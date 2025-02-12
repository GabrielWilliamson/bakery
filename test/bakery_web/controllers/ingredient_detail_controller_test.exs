defmodule BakeryWeb.IngredientDetailControllerTest do
  use BakeryWeb.ConnCase

  import Bakery.IngredientsDetailsFixtures

  @create_attrs %{price: "120.5"}
  @update_attrs %{price: "456.7"}
  @invalid_attrs %{price: nil}

  describe "index" do
    test "lists all ingredients_details", %{conn: conn} do
      conn = get(conn, ~p"/ingredients_details")
      assert html_response(conn, 200) =~ "Listing Ingredients details"
    end
  end

  describe "new ingredient_detail" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/ingredients_details/new")
      assert html_response(conn, 200) =~ "New Ingredient detail"
    end
  end

  describe "create ingredient_detail" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/ingredients_details", ingredient_detail: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/ingredients_details/#{id}"

      conn = get(conn, ~p"/ingredients_details/#{id}")
      assert html_response(conn, 200) =~ "Ingredient detail #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/ingredients_details", ingredient_detail: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Ingredient detail"
    end
  end

  describe "edit ingredient_detail" do
    setup [:create_ingredient_detail]

    test "renders form for editing chosen ingredient_detail", %{conn: conn, ingredient_detail: ingredient_detail} do
      conn = get(conn, ~p"/ingredients_details/#{ingredient_detail}/edit")
      assert html_response(conn, 200) =~ "Edit Ingredient detail"
    end
  end

  describe "update ingredient_detail" do
    setup [:create_ingredient_detail]

    test "redirects when data is valid", %{conn: conn, ingredient_detail: ingredient_detail} do
      conn = put(conn, ~p"/ingredients_details/#{ingredient_detail}", ingredient_detail: @update_attrs)
      assert redirected_to(conn) == ~p"/ingredients_details/#{ingredient_detail}"

      conn = get(conn, ~p"/ingredients_details/#{ingredient_detail}")
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, ingredient_detail: ingredient_detail} do
      conn = put(conn, ~p"/ingredients_details/#{ingredient_detail}", ingredient_detail: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Ingredient detail"
    end
  end

  describe "delete ingredient_detail" do
    setup [:create_ingredient_detail]

    test "deletes chosen ingredient_detail", %{conn: conn, ingredient_detail: ingredient_detail} do
      conn = delete(conn, ~p"/ingredients_details/#{ingredient_detail}")
      assert redirected_to(conn) == ~p"/ingredients_details"

      assert_error_sent 404, fn ->
        get(conn, ~p"/ingredients_details/#{ingredient_detail}")
      end
    end
  end

  defp create_ingredient_detail(_) do
    ingredient_detail = ingredient_detail_fixture()
    %{ingredient_detail: ingredient_detail}
  end
end
