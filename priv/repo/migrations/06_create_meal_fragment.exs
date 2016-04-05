defmodule GroceryGnome.Repo.Migrations.CreateMealFragment do
  use Ecto.Migration

  def change do
    create table(:mealfragments) do
      add :MealFragmentID, :integer
      add :MealFragment_MealID, references(:meals)
      add :MealFragment_RecipeID, references(:recipecatalogs)

      timestamps
    end

  end
end
