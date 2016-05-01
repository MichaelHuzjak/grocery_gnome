defmodule GroceryGnome.Repo.Migrations.CreatePantryitem do
  use Ecto.Migration

  def change do
    create table(:pantryitems) do
      add :pantryquantity, :float
      add :expiration, :date
			add :monitor, :boolean
			add :baselevel, :float
      add :user_id, references(:users)
      add :foodcatalog_id, references(:foodcatalogs)

      timestamps
    end
		create unique_index(:pantryitems, [:user_id, :foodcatalog_id], name: :pantry_item_index)
    #create index(:pantryitems, [:user_id])
    #create index(:pantryitems, [:foodcatalog_id])

  end
end
