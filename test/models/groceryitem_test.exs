defmodule GroceryGnome.GroceryitemTest do
  use GroceryGnome.ModelCase

  alias GroceryGnome.Groceryitem

  @valid_attrs %{groceryquantity: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Groceryitem.changeset(%Groceryitem{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Groceryitem.changeset(%Groceryitem{}, @invalid_attrs)
    refute changeset.valid?
  end
end
