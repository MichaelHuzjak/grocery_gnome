defmodule GroceryGnome.GroceryListTest do
  use GroceryGnome.ModelCase

  alias GroceryGnome.GroceryList

  @valid_attrs %{GroceryListID: 42, GroceryList_AccountID: 42, GroceryList_FoodID: 42, GroceryList_RecipeID: "some content", integer: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = GroceryList.changeset(%GroceryList{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = GroceryList.changeset(%GroceryList{}, @invalid_attrs)
    refute changeset.valid?
  end
end
