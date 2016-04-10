defmodule GroceryGnome.Repo.Migrations.CreatePantryitem do
  use Ecto.Migration

  def change do
    create table(:pantryitems) do
      add :pantryquantity, :float
      add :expiration, :string
      add :user_id, references(:users)
      add :foodcatalog_id, references(:foodcatalogs)

      timestamps
    end
    create index(:pantryitems, [:user_id])
    create index(:pantryitems, [:foodcatalog_id])

  end
end
