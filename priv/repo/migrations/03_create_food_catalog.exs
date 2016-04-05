defmodule GroceryGnome.Repo.Migrations.CreateFoodCatalog do
  use Ecto.Migration

  def change do
    create table(:foodcatalogs) do
      add :FoodID, :integer
      add :FoodName, :string
      add :foodPrice, :decimal

      timestamps
    end

  end
end
