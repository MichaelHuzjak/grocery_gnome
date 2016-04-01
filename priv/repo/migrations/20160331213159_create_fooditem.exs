defmodule GroceryGnome.Repo.Migrations.CreateFooditem do
  use Ecto.Migration

  def change do
    create table(:fooditems) do
      add :foodname, :string
      add :user_id, references(:users)

      timestamps
    end
    create index(:fooditems, [:user_id])

  end
end
