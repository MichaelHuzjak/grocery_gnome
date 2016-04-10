defmodule GroceryGnome.PantryitemTest do
  use GroceryGnome.ModelCase

  alias GroceryGnome.Pantryitem

  @valid_attrs %{expiration: "some content", pantryquantity: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Pantryitem.changeset(%Pantryitem{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Pantryitem.changeset(%Pantryitem{}, @invalid_attrs)
    refute changeset.valid?
  end
end
