defmodule GroceryGnome.MealTest do
  use GroceryGnome.ModelCase

  alias GroceryGnome.Meal

  @valid_attrs %{MealID: 42, Meal_FoodPantryID: 42, Meal_RecipeID: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Meal.changeset(%Meal{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Meal.changeset(%Meal{}, @invalid_attrs)
    refute changeset.valid?
  end
end
