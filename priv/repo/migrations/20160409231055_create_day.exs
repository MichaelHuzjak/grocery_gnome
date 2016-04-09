defmodule GroceryGnome.Repo.Migrations.CreateDay do
  use Ecto.Migration

  def change do
    create table(:days) do
      add :breakfast, {:array, :id}
      add :lunch, {:array, :id}
      add :dinner, {:array, :id}
      add :date, :map
      add :user_id, references(:users)

      timestamps
    end
    create index(:days, [:user_id])

  end
end
