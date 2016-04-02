defmodule GroceryGnome.Repo.Migrations.CreateMealFragment do
  use Ecto.Migration

  def change do
    create table(:mealfragments) do
      add :MealFragmentID, :integer
      add :MealFragment_MealID, :integer
      add :MealFragment_RecipeID, :integer

      timestamps
    end

  end
end
