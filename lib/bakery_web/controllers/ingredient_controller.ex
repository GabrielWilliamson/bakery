defmodule BakeryWeb.IngredientController do
  use BakeryWeb, :controller

  alias Bakery.Ingredients
  alias Bakery.Units
  alias Bakery.Ingredients.Ingredient
  alias Bakery.IngredientsDetails

  def index(conn, _params) do
    tenant = conn.assigns.current_user.tenant
    ingredients = Ingredients.list_ingredients(tenant)
    render(conn, :index, ingredients: ingredients)
  end

  def new(conn, _params) do
    tenant = conn.assigns.current_user.tenant
    find_units = Units.list_units_base(tenant)
    changeset = Ingredients.change_ingredient(%Ingredient{})
    render(conn, :new, changeset: changeset, units: find_units)
  end

  def create(conn, %{"ingredient" => ingredient_params}) do
    tenant = conn.assigns.current_user.tenant

    case Ingredients.create_ingredient(ingredient_params, tenant) do
      {:ok, ingredient} ->
        conn
        |> put_flash(:info, "Ingredient created successfully.")
        |> redirect(to: ~p"/ingredients/#{ingredient}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tenant = conn.assigns.current_user.tenant
    ingredient = Ingredients.get_full_ingredient!(id, tenant)
    ingredient_detail = IngredientsDetails.list_ingredients_details(id, tenant)
    render(conn, :show, ingredient: ingredient, details: ingredient_detail)
  end

  def edit(conn, %{"id" => id}) do
    tenant = conn.assigns.current_user.tenant
    find_units = Units.list_units_base(tenant)
    ingredient = Ingredients.get_ingredient!(id, tenant)
    changeset = Ingredients.change_ingredient(ingredient)
    render(conn, :edit, ingredient: ingredient, changeset: changeset, units: find_units)
  end

  def update(conn, %{"id" => id, "ingredient" => ingredient_params}) do
    tenant = conn.assigns.current_user.tenant

    ingredient = Ingredients.get_ingredient!(id, tenant)

    case Ingredients.update_ingredient(ingredient, ingredient_params, tenant) do
      {:ok, ingredient} ->
        conn
        |> put_flash(:info, "Ingredient updated successfully.")
        |> redirect(to: ~p"/ingredients/#{ingredient}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, ingredient: ingredient, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tenant = conn.assigns.current_user.tenant

    ingredient = Ingredients.get_ingredient!(id, tenant)

    {:ok, _ingredient} = Ingredients.delete_ingredient(ingredient, tenant)

    conn
    |> put_flash(:info, "Ingredient deleted successfully.")
    |> redirect(to: ~p"/ingredients")
  end
end
