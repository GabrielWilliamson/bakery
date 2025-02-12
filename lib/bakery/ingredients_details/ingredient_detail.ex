defmodule Bakery.IngredientsDetails.IngredientDetail do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ingredients_details" do
    field :price, :decimal
    field :unit_id, :id
    field :ingredient_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ingredient_detail, attrs) do
    ingredient_detail
    |> cast(attrs, [:price, :ingredient_id, :unit_id])
    |> validate_required([:price, :ingredient_id, :unit_id])
  end
end
