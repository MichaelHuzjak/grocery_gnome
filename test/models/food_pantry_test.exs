defmodule GroceryGnome.FoodPantryTest do
  use GroceryGnome.ModelCase

  alias GroceryGnome.FoodPantry

  @valid_attrs %{FoodPantryID: 42, FoodPantry_FoodID: 42, Quantity: "120.5", Units: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = FoodPantry.changeset(%FoodPantry{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = FoodPantry.changeset(%FoodPantry{}, @invalid_attrs)
    refute changeset.valid?
  end
end
