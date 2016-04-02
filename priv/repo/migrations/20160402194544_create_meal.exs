defmodule GroceryGnome.Repo.Migrations.CreateMeal do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add :MealID, :integer
      add :Meal_RecipeID, :integer
      add :Meal_FoodPantryID, :integer

      timestamps
    end

  end
end
