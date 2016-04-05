defmodule GroceryGnome.Repo.Migrations.CreateSchedule do
  use Ecto.Migration

  def change do
		
			# Create schedules table
    create table(:schedules) do
      add :ScheduleID, :integer
      add :Schedule_AccountID, :integer
      add :WeekDate, :string
      add :SundayMealPlanID, references(:dailymealplans)
      add :MondayMealPlanID, references(:dailymealplans)
      add :TuesdayMealPlanID, references(:dailymealplans)
      add :WednesdayMealPlanID, references(:dailymealplans)
      add :ThursdayMealPlanID, references(:dailymealplans)
      add :FridayMealPlanID, references(:dailymealplans)
      add :SaturdayMealPlanID, references(:dailymealplans)

      timestamps
     end
		# Create meal fragment FK
		create index(:mealfragments, [:MealFragment_MealID])
		# Create DailyMealPlan FK's
		create index(:dailymealplans, [:BreakfastID])
		create index(:dailymealplans, [:LunchID])
		create index(:dailymealplans, [:DinnerID])

		#Create Schedule FK's
		create index(:schedules, [:SundayMealPlanID])
		create index(:schedules, [:MondayMealPlanID])
		create index(:schedules, [:TuesdayMealPlanID])
		create index(:schedules, [:WednesdayMealPlanID])
		create index(:schedules, [:ThursdayMealPlanID])
		create index(:schedules, [:FridayMealPlanID])
		create index(:schedules, [:SaturdayMealPlanID])

  end
end
