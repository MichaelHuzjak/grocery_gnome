defmodule GroceryGnome.Repo.Migrations.CreateSchedule do
  use Ecto.Migration

  def change do
    create table(:schedules) do
      add :ScheduleID, :integer
      add :Schedule_AccountID, :integer
      add :WeekDate, :string
      add :SundayMealPlanID, :integer
      add :MondayMealPlanID, :integer
      add :TuesdayMealPlanID, :integer
      add :WednesdayMealPlanID, :integer
      add :ThursdayMealPlanID, :integer
      add :FridayMealPlanID, :integer
      add :SaturdayMealPlanID, :integer

      timestamps
    end

  end
end
