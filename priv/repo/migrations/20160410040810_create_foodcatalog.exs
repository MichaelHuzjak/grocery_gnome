defmodule GroceryGnome.Repo.Migrations.CreateFoodcatalog do
  use Ecto.Migration

  def change do
    create table(:foodcatalogs) do
      add :foodname, :string
      add :info, :string
      add :unit, :string

      timestamps
    end
		create unique_index(:foodcatalogs, [:foodname], name: :foodname_index)
  end
end
