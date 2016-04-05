defmodule GroceryGnome.Repo.Migrations.CreateIngredient do
  use Ecto.Migration

  def change do
    create table(:ingredients) do
      add :IngredientID, :integer
      add :Ingredient_RecipeID, references(:recipecatalogs)
      add :Ingredient_FoodID, references(:foodcatalogs)

      timestamps
    end

  end
end
