defmodule GroceryGnome.Repo.Migrations.CreateMealplan do
  use Ecto.Migration

  def change do
    create table(:mealplans) do
      add :breakfast, :string
      add :lunch, :string
      add :dinner, :string

      timestamps
    end

  end
end
