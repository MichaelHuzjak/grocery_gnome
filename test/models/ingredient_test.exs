defmodule GroceryGnome.IngredientTest do
  use GroceryGnome.ModelCase

  alias GroceryGnome.Ingredient

  @valid_attrs %{IngredientID: 42, Ingredient_FoodID: 42, Ingredient_RecipeID: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Ingredient.changeset(%Ingredient{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Ingredient.changeset(%Ingredient{}, @invalid_attrs)
    refute changeset.valid?
  end
end
