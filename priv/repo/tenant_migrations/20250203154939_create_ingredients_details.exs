defmodule Bakery.Repo.Migrations.CreateIngredientsDetails do
  use Ecto.Migration

  def change do
    create table(:ingredients_details) do
      add :price, :decimal
      add :unit_id, references(:units, on_delete: :nothing)
      add :ingredient_id, references(:ingredients, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:ingredients_details, [:unit_id])
    create index(:ingredients_details, [:ingredient_id])
  end
end
