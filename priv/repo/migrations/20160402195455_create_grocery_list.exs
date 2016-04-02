defmodule GroceryGnome.Repo.Migrations.CreateGroceryList do
  use Ecto.Migration

  def change do
    create table(:grocerylists) do
      add :GroceryListID, :integer
      add :GroceryList_AccountID, :integer
      add :GroceryList_FoodID, :integer
      add :GroceryList_RecipeID, :string
      add :integer, :string

      timestamps
    end

  end
end
