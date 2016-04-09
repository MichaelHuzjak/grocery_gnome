defmodule GroceryGnome.Repo.Migrations.CreateRecipe do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :ingredients, :map
      add :instructions, :string
      add :prep_time, :integer
      add :cook_time, :integer
      add :author_id, references(:users)

      timestamps
    end
    create index(:recipes, [:author_id])

  end
end
