defmodule GroceryGnome.Repo.Migrations.CreateMeal do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add :MealID, :integer
      add :Meal_RecipeID, references(:recipecatalogs)
      add :Meal_FoodPantryID, references(:foodpantries)

      timestamps
    end

  end
end
