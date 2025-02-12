defmodule BakeryWeb.IngredientControllerTest do
  use BakeryWeb.ConnCase

  import Bakery.IngredientsFixtures

  @create_attrs %{name: "some name", price: "120.5"}
  @update_attrs %{name: "some updated name", price: "456.7"}
  @invalid_attrs %{name: nil, price: nil}

  describe "index" do
    test "lists all ingredients", %{conn: conn} do
      conn = get(conn, ~p"/ingredients")
      assert html_response(conn, 200) =~ "Listing Ingredients"
    end
  end

  describe "new ingredient" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/ingredients/new")
      assert html_response(conn, 200) =~ "New Ingredient"
    end
  end

  describe "create ingredient" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/ingredients", ingredient: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/ingredients/#{id}"

      conn = get(conn, ~p"/ingredients/#{id}")
      assert html_response(conn, 200) =~ "Ingredient #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/ingredients", ingredient: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Ingredient"
    end
  end

  describe "edit ingredient" do
    setup [:create_ingredient]

    test "renders form for editing chosen ingredient", %{conn: conn, ingredient: ingredient} do
      conn = get(conn, ~p"/ingredients/#{ingredient}/edit")
      assert html_response(conn, 200) =~ "Edit Ingredient"
    end
  end

  describe "update ingredient" do
    setup [:create_ingredient]

    test "redirects when data is valid", %{conn: conn, ingredient: ingredient} do
      conn = put(conn, ~p"/ingredients/#{ingredient}", ingredient: @update_attrs)
      assert redirected_to(conn) == ~p"/ingredients/#{ingredient}"

      conn = get(conn, ~p"/ingredients/#{ingredient}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, ingredient: ingredient} do
      conn = put(conn, ~p"/ingredients/#{ingredient}", ingredient: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Ingredient"
    end
  end

  describe "delete ingredient" do
    setup [:create_ingredient]

    test "deletes chosen ingredient", %{conn: conn, ingredient: ingredient} do
      conn = delete(conn, ~p"/ingredients/#{ingredient}")
      assert redirected_to(conn) == ~p"/ingredients"

      assert_error_sent 404, fn ->
        get(conn, ~p"/ingredients/#{ingredient}")
      end
    end
  end

  defp create_ingredient(_) do
    ingredient = ingredient_fixture()
    %{ingredient: ingredient}
  end
end
