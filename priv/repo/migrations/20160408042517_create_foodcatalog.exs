defmodule GroceryGnome.Repo.Migrations.CreateFoodcatalog do
  use Ecto.Migration

  def change do
    create table(:foodcatalogs) do
      add :foodname, :string
      add :foodquantity, :decimal
      add :foodunit, :string
      add :user_id, references(:users)

      timestamps
    end
    create index(:foodcatalogs, [:user_id])

  end
end
