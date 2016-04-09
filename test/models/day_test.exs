defmodule GroceryGnome.DayTest do
  use GroceryGnome.ModelCase

  alias GroceryGnome.Day

  @valid_attrs %{breakfast: [], date: "some content", dinner: [], lunch: []}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Day.changeset(%Day{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Day.changeset(%Day{}, @invalid_attrs)
    refute changeset.valid?
  end
end
