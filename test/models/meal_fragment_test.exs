defmodule GroceryGnome.MealFragmentTest do
  use GroceryGnome.ModelCase

  alias GroceryGnome.MealFragment

  @valid_attrs %{MealFragmentID: 42, MealFragment_MealID: 42, MealFragment_RecipeID: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = MealFragment.changeset(%MealFragment{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = MealFragment.changeset(%MealFragment{}, @invalid_attrs)
    refute changeset.valid?
  end
end
