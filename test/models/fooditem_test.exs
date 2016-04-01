defmodule GroceryGnome.FooditemTest do
  use GroceryGnome.ModelCase

  alias GroceryGnome.Fooditem

  @valid_attrs %{foodname: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Fooditem.changeset(%Fooditem{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Fooditem.changeset(%Fooditem{}, @invalid_attrs)
    refute changeset.valid?
  end
end
