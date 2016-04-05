defmodule GroceryGnome.Repo.Migrations.CreateDailyMealPlan do
  use Ecto.Migration

  def change do
    create table(:dailymealplans) do
      add :DailyMealPlanID, :integer
      add :BreakfastID, references(:meals)
      add :LunchID, references(:meals)
      add :DinnerID, references(:meals)

      timestamps
    end

  end
end
