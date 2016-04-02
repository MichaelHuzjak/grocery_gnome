defmodule GroceryGnome.ScheduleTest do
  use GroceryGnome.ModelCase

  alias GroceryGnome.Schedule

  @valid_attrs %{FridayMealPlanID: 42, MondayMealPlanID: 42, SaturdayMealPlanID: 42, ScheduleID: 42, Schedule_AccountID: 42, SundayMealPlanID: 42, ThursdayMealPlanID: 42, TuesdayMealPlanID: 42, WednesdayMealPlanID: 42, WeekDate: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Schedule.changeset(%Schedule{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Schedule.changeset(%Schedule{}, @invalid_attrs)
    refute changeset.valid?
  end
end
