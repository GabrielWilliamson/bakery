defmodule Bakery.Ingredients do
  @moduledoc """
  The Ingredients context.
  """

  import Ecto.Query, warn: false
  alias Bakery.Repo
  alias Bakery.Units.Unit
  alias Bakery.Ingredients.Ingredient

  @doc """
  Returns the list of ingredients.

  ## Examples

      iex> list_ingredients()
      [%Ingredient{}, ...]

  """
  def list_ingredients(tenant) do
    from(i in Ingredient,
      join: u in Unit,
      on: i.unit_id == u.id,
      select: %{
        id: i.id,
        name: i.name,
        price: i.price,
        unit_name: u.name
      }
    )
    |> Repo.all(prefix: Triplex.to_prefix(tenant))
  end

  @doc """
  Gets a single ingredient.

  Raises `Ecto.NoResultsError` if the Ingredient does not exist.

  ## Examples

      iex> get_ingredient!(123)
      %Ingredient{}

      iex> get_ingredient!(456)
      ** (Ecto.NoResultsError)

  """

  def get_ingredient!(id, tenant) do
    from(i in Ingredient,
      where: i.id == ^id
    )
    |> Repo.one!(prefix: Triplex.to_prefix(tenant))
  end

  def get_full_ingredient!(id, tenant) do
    # evaluar que le pertenezca
    from(i in Ingredient,
      join: u in Unit,
      on: i.unit_id == u.id,
      where: i.id == ^id,
      select: %{
        id: i.id,
        name: i.name,
        price: i.price,
        short: u.short,
        unit_id: i.unit_id
      }
    )
    |> Repo.one(prefix: Triplex.to_prefix(tenant))
  end

  @doc """
  Creates a ingredient.

  ## Examples

      iex> create_ingredient(%{field: value})
      {:ok, %Ingredient{}}

      iex> create_ingredient(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ingredient(attrs \\ %{}, tenant) do
    %Ingredient{}
    |> Ingredient.changeset(attrs)
    |> Repo.insert(prefix: Triplex.to_prefix(tenant))
  end

  @doc """
  Updates a ingredient.

  ## Examples

      iex> update_ingredient(ingredient, %{field: new_value})
      {:ok, %Ingredient{}}

      iex> update_ingredient(ingredient, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ingredient(%Ingredient{} = ingredient, attrs, tenant) do
    # update details for this ingredient
    ingredient
    |> Ingredient.changeset(attrs)
    |> Repo.update(prefix: Triplex.to_prefix(tenant))
  end

  @doc """
  Deletes a ingredient.

  ## Examples

      iex> delete_ingredient(ingredient)
      {:ok, %Ingredient{}}

      iex> delete_ingredient(ingredient)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ingredient(%Ingredient{} = ingredient, tenant) do
    Repo.delete(ingredient, prefix: Triplex.to_prefix(tenant))
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ingredient changes.

  ## Examples

      iex> change_ingredient(ingredient)
      %Ecto.Changeset{data: %Ingredient{}}

  """

  def change_ingredient(%Ingredient{} = ingredient, attrs \\ %{}) do
    Ingredient.changeset(ingredient, attrs)
  end
end
