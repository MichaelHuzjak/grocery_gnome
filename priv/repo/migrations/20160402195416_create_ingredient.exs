defmodule GroceryGnome.Repo.Migrations.CreateIngredient do
  use Ecto.Migration

  def change do
    create table(:ingredients) do
      add :IngredientID, :integer
      add :Ingredient_RecipeID, :integer
      add :Ingredient_FoodID, :integer

      timestamps
    end

  end
end
