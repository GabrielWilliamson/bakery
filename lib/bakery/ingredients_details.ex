defmodule Bakery.IngredientsDetails do
  @moduledoc """
  The IngredientsDetails context.
  """

  import Ecto.Query, warn: false

  alias Bakery.Repo
  alias Bakery.Units.Unit
  alias Bakery.Ingredients.Ingredient
  alias Bakery.IngredientsDetails.IngredientDetail
  alias Bakery.Convertions.Convertion

  @doc """
  Returns the list of ingredients_details.

  ## Examples

      iex> list_ingredients_details()
      [%IngredientDetail{}, ...]

  """
  def list_ingredients_details(ingredient_id, tenant) do
    from(d in IngredientDetail,
      join: u in Unit,
      on: d.unit_id == u.id,
      where: d.ingredient_id == ^ingredient_id,
      select: %{
        id: d.id,
        price: d.price,
        short: u.short
      }
    )
    |> Repo.all(prefix: Triplex.to_prefix(tenant))
  end

  @doc """
  Gets a single ingredient_detail.

  Raises `Ecto.NoResultsError` if the Ingredient detail does not exist.

  ## Examples

      iex> get_ingredient_detail!(123)
      %IngredientDetail{}

      iex> get_ingredient_detail!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ingredient_detail!(id, tenant),
    do: Repo.get!(IngredientDetail, id, prefix: Triplex.to_prefix(tenant))

  @doc """
  Creates a ingredient_detail.
  """
  def create_ingredient_detail(attrs \\ %{}, tenant) do
    ingredient = Repo.get!(Ingredient, attrs["ingredient_id"], prefix: Triplex.to_prefix(tenant))

    exists =
      from(d in IngredientDetail,
        where: d.ingredient_id == ^ingredient.id and d.unit_id == ^attrs["unit_id"],
        select: d.id
      )
      |> Repo.exists?(prefix: Triplex.to_prefix(tenant))

    if exists do
      {:error, "There is already a detail for this ingredient with this unit of measurement."}
    else
      convertion =
        from(c in Convertion,
          where: c.from_unit_id == ^attrs["unit_id"] and c.to_unit_id == ^ingredient.unit_id,
          select: %{factor: c.conversion_factor}
        )
        |> Repo.one(prefix: Triplex.to_prefix(tenant))

      case convertion do
        nil ->
          {:error, "No valid conversion was found between the specified units."}

        %{factor: factor} ->
          converted_price = Decimal.mult(ingredient.price, factor)

          attrs = Map.put(attrs, "price", converted_price)

          %IngredientDetail{}
          |> IngredientDetail.changeset(attrs)
          |> Repo.insert(prefix: Triplex.to_prefix(tenant))
      end
    end
  end

  @doc """
  Updates a ingredient_detail.

  ## Examples

      iex> update_ingredient_detail(ingredient_detail, %{field: new_value})
      {:ok, %IngredientDetail{}}

      iex> update_ingredient_detail(ingredient_detail, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ingredient_detail(%IngredientDetail{} = ingredient_detail, attrs, tenant) do
    ingredient_detail
    |> IngredientDetail.changeset(attrs)
    |> Repo.update(prefix: Triplex.to_prefix(tenant))
  end

  @doc """
  Deletes a ingredient_detail.

  ## Examples

      iex> delete_ingredient_detail(ingredient_detail)
      {:ok, %IngredientDetail{}}

      iex> delete_ingredient_detail(ingredient_detail)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ingredient_detail(%IngredientDetail{} = ingredient_detail, tenant) do
    Repo.delete(ingredient_detail, prefix: Triplex.to_prefix(tenant))
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ingredient_detail changes.

  ## Examples

      iex> change_ingredient_detail(ingredient_detail)
      %Ecto.Changeset{data: %IngredientDetail{}}

  """
  def change_ingredient_detail(%IngredientDetail{} = ingredient_detail, attrs \\ %{}) do
    IngredientDetail.changeset(ingredient_detail, attrs)
  end
end
