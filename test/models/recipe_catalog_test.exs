defmodule GroceryGnome.RecipeCatalogTest do
  use GroceryGnome.ModelCase

  alias GroceryGnome.RecipeCatalog

  @valid_attrs %{PreparationTimeInMinues: 42, RecipeID: 42, RecipeName: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = RecipeCatalog.changeset(%RecipeCatalog{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = RecipeCatalog.changeset(%RecipeCatalog{}, @invalid_attrs)
    refute changeset.valid?
  end
end
