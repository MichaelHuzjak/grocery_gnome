defmodule GroceryGnome.Repo.Migrations.CreateGroceryitem do
  use Ecto.Migration

  def change do
    create table(:groceryitems) do
      add :groceryquantity, :float
      add :user_id, references(:users)
      add :foodcatalog_id, references(:foodcatalogs)

      timestamps
    end
		create unique_index(:pantryitems, [:user_id, :foodcatalog_id], name: :grocery_item_index)

  end
end
