defmodule Bakery.Repo.Migrations.CreateConvertions do
  use Ecto.Migration

  def change do
    create table(:convertions) do
      add :conversion_factor, :decimal
      add :from_unit_id, references(:units, on_delete: :nothing)
      add :to_unit_id, references(:units, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:convertions, [:from_unit_id])
    create index(:convertions, [:to_unit_id])
  end
end
