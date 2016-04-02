defmodule GroceryGnome.DailyMealPlanTest do
  use GroceryGnome.ModelCase

  alias GroceryGnome.DailyMealPlan

  @valid_attrs %{BreakfastID: 42, DailyMealPlanID: 42, DinnerID: 42, LunchID: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = DailyMealPlan.changeset(%DailyMealPlan{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = DailyMealPlan.changeset(%DailyMealPlan{}, @invalid_attrs)
    refute changeset.valid?
  end
end
