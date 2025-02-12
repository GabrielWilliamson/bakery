defmodule BakeryWeb.IngredientDetailController do
  use BakeryWeb, :controller

  alias Bakery.Units
  alias Bakery.Ingredients
  alias Bakery.IngredientsDetails
  alias Bakery.IngredientsDetails.IngredientDetail

  def new(conn, %{"id" => id}) do
    tenant = conn.assigns.current_user.tenant
    ingredient = Ingredients.get_ingredient!(id, tenant)
    find_units = Units.list_units_base(tenant)

    changeset = IngredientsDetails.change_ingredient_detail(%IngredientDetail{ingredient_id: id})
    render(conn, :new, changeset: changeset, ingredient: ingredient, units: find_units)
  end

  def create(conn, %{"ingredient_detail" => ingredient_detail_params}) do
    tenant = conn.assigns.current_user.tenant

    case IngredientsDetails.create_ingredient_detail(ingredient_detail_params, tenant) do
      {:ok, ingredient_detail} ->
        conn
        |> put_flash(:info, "Ingredient detail created successfully.")
        |> redirect(to: ~p"/ingredients/#{ingredient_detail.ingredient_id}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)

      # Manejo del error en forma de string
      {:error, message} when is_binary(message) ->
        conn
        |> put_flash(:error, message)
        # Redirige a la vista de creación nuevamente
        |> redirect(to: ~p"/ingredients/#{ingredient_detail_params["ingredient_id"]}")
    end
  end

  def show(conn, %{"id" => id}) do
    tenant = conn.assigns.current_user.tenant
    ingredient_detail = IngredientsDetails.get_ingredient_detail!(id, tenant)
    render(conn, :show, ingredient_detail: ingredient_detail)
  end

  def edit(conn, %{"id" => id}) do
    tenant = conn.assigns.current_user.tenant
    ingredient_detail = IngredientsDetails.get_ingredient_detail!(id, tenant)
    changeset = IngredientsDetails.change_ingredient_detail(ingredient_detail)
    render(conn, :edit, ingredient_detail: ingredient_detail, changeset: changeset)
  end

  def update(conn, %{"id" => id, "ingredient_detail" => ingredient_detail_params}) do
    tenant = conn.assigns.current_user.tenant
    ingredient_detail = IngredientsDetails.get_ingredient_detail!(id, tenant)

    case IngredientsDetails.update_ingredient_detail(
           ingredient_detail,
           ingredient_detail_params,
           tenant
         ) do
      {:ok, ingredient_detail} ->
        conn
        |> put_flash(:info, "Ingredient detail updated successfully.")
        |> redirect(to: ~p"/ingredients_details/#{ingredient_detail}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, ingredient_detail: ingredient_detail, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tenant = conn.assigns.current_user.tenant
    ingredient_detail = IngredientsDetails.get_ingredient_detail!(id, tenant)

    {:ok, _ingredient_detail} =
      IngredientsDetails.delete_ingredient_detail(ingredient_detail, tenant)

    conn
    |> put_flash(:info, "Ingredient detail deleted successfully.")
    |> redirect(to: ~p"/ingredients_details")
  end
end
