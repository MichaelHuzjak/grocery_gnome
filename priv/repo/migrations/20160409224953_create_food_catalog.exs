defmodule GroceryGnome.Repo.Migrations.CreateFoodCatalog do
  use Ecto.Migration

  def change do
    create table(:food_catalog) do
      add :units, :string
      add :name, :string
      add :info, :string

      timestamps
    end

  end
end
