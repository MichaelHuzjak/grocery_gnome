defmodule GroceryGnome.Repo.Migrations.CreateMeal do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add :meal_type, :integer
      add :recipe_id, references(:recipes)
      add :day_id, references(:days)

      timestamps
    end
    create index(:meals, [:recipe_id])
    create index(:meals, [:day_id])

  end
end
