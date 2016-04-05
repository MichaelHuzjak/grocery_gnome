defmodule GroceryGnome.Repo.Migrations.CreateGroceryList do
  use Ecto.Migration

  def change do
    create table(:grocerylists) do
      add :GroceryListID, :integer
      add :GroceryList_AccountID, references(:accounts)
      add :GroceryList_FoodID, references(:foodcatalogs)
      add :GroceryList_RecipeID, references(:recipecatalogs)
      add :integer, :string

      timestamps
    end

  end
end
