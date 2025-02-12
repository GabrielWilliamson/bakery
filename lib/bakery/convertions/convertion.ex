defmodule Bakery.Convertions.Convertion do
  use Ecto.Schema
  import Ecto.Changeset

  schema "convertions" do
    field :conversion_factor, :decimal
    belongs_to :from_unit, Bakery.Units.Unit, foreign_key: :from_unit_id
    belongs_to :to_unit, Bakery.Units.Unit, foreign_key: :to_unit_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(convertion, attrs) do
    convertion
    |> cast(attrs, [:conversion_factor, :from_unit_id, :to_unit_id])
    |> validate_required([:conversion_factor, :from_unit_id, :to_unit_id])
    |> validate_number(:conversion_factor, greater_than: 0)
    |> unique_constraint([:from_unit_id, :to_unit_id])
  end
end
