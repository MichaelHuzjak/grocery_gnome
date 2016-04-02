defmodule GroceryGnome.FoodCatalogTest do
  use GroceryGnome.ModelCase

  alias GroceryGnome.FoodCatalog

  @valid_attrs %{FoodID: 42, FoodName: "some content", foodPrice: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = FoodCatalog.changeset(%FoodCatalog{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = FoodCatalog.changeset(%FoodCatalog{}, @invalid_attrs)
    refute changeset.valid?
  end
end
