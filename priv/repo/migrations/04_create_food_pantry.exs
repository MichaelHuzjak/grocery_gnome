defmodule GroceryGnome.Repo.Migrations.CreateMeal do
  use Ecto.Migration

  def change do
    create table(:foodpantries) do
			add :FoodPantryID, :integer
			add :FoodPnatry_FoodID, references(:foodcatalogs)
			add :Quantity, :decimal
			add :Units, :string

      timestamps
    end
		
  end
end
