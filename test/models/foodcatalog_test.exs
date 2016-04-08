defmodule GroceryGnome.FoodcatalogTest do
  use GroceryGnome.ModelCase

  alias GroceryGnome.Foodcatalog

  @valid_attrs %{foodname: "some content", foodquantity: "120.5", foodunit: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Foodcatalog.changeset(%Foodcatalog{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Foodcatalog.changeset(%Foodcatalog{}, @invalid_attrs)
    refute changeset.valid?
  end
end
