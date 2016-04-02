defmodule GroceryGnome.Repo.Migrations.CreateDailyMealPlan do
  use Ecto.Migration

  def change do
    create table(:dailymealplans) do
      add :DailyMealPlanID, :integer
      add :BreakfastID, :integer
      add :LunchID, :integer
      add :DinnerID, :integer

      timestamps
    end

  end
end
