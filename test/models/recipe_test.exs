defmodule GroceryGnome.RecipeTest do
  use GroceryGnome.ModelCase

  alias GroceryGnome.Recipe

  @valid_attrs %{cook_time: 42, ingredients: %{}, instructions: "some content", prep_time: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Recipe.changeset(%Recipe{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Recipe.changeset(%Recipe{}, @invalid_attrs)
    refute changeset.valid?
  end
end
