defmodule GroceryGnome.PantryItemTest do
  use GroceryGnome.ModelCase

  alias GroceryGnome.PantryItem

  @valid_attrs %{expiration: %{}, quantity: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PantryItem.changeset(%PantryItem{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PantryItem.changeset(%PantryItem{}, @invalid_attrs)
    refute changeset.valid?
  end
end
