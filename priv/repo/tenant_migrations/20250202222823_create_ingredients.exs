defmodule Bakery.Repo.Migrations.CreateIngredients do
  use Ecto.Migration

  def change do
    create table(:ingredients) do
      add :name, :string
      add :price, :decimal
      add :unit_id, references(:units, on_delete: :nothing)


      timestamps(type: :utc_datetime)
    end
  end
end
