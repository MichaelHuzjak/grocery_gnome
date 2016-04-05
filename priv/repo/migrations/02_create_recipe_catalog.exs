defmodule GroceryGnome.Repo.Migrations.CreateRecipeCatalog do
  use Ecto.Migration

  def change do
    create table(:recipecatalogs) do
      add :RecipeID, :integer
      add :RecipeName, :string
      add :PreparationTimeInMinues, :integer

      timestamps
    end

  end
end
