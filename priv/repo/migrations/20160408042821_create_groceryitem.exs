defmodule GroceryGnome.Repo.Migrations.CreateGroceryitem do
  use Ecto.Migration

  def change do
    create table(:groceryitems) do
      add :groceryquantity, :decimal
      add :user_id, references(:users)
      add :foodcatalog_id, references(:foodcatalogs)

      timestamps
    end
    create index(:groceryitems, [:user_id])
    create index(:groceryitems, [:foodcatalog_id])

  end
end
