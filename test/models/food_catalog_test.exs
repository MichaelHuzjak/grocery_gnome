defmodule GroceryGnome.FoodCatalogTest do
  use GroceryGnome.ModelCase

  alias GroceryGnome.FoodCatalog

  @valid_attrs %{info: "some content", name: "some content", units: "some content"}
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
