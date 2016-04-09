defmodule GroceryGnome.Repo.Migrations.CreatePantryItem do
  use Ecto.Migration

  def change do
    create table(:pantry_items) do
      add :quantity, :float
      add :expiration, :map
      add :user_id, references(:users)
      add :food_catalog_id, references(:food_catalog)

      timestamps
    end
    create index(:pantry_items, [:user_id])
    create index(:pantry_items, [:food_catalog_id])

  end
end
