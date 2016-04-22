defmodule GroceryGnome.Repo.Migrations.CreateIngredient do
  use Ecto.Migration

  def change do
    create table(:ingredients) do
      add :ingredientquantity, :float
      add :recipe_id, references(:recipes)
      add :foodcatalog_id, references(:foodcatalogs)

      timestamps
    end
    create index(:ingredients, [:recipe_id])
    create index(:ingredients, [:foodcatalog_id])

  end
end
