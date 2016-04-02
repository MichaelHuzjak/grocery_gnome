defmodule GroceryGnome.Repo.Migrations.CreateFoodPantry do
  use Ecto.Migration

  def change do
    create table(:foodpantries) do
      add :FoodPantryID, :integer
      add :FoodPantry_FoodID, :integer
      add :Quantity, :decimal
      add :Units, :string

      timestamps
    end

  end
end
