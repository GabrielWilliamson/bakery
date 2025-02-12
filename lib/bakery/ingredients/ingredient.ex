defmodule Bakery.Ingredients.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ingredients" do
    field :name, :string
    field :price, :decimal
    belongs_to :unit, Bakery.Units.Unit, foreign_key: :unit_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ingredient, attrs) do
    ingredient
    |> cast(attrs, [:name, :price, :unit_id])
    |> validate_required([:name, :price, :unit_id])
  end
end
