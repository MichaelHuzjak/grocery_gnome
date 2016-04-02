defmodule GroceryGnome.FavoriteTest do
  use GroceryGnome.ModelCase

  alias GroceryGnome.Favorite

  @valid_attrs %{FavoriteID: 42, Favorite_AccountID: 42, Favorite_RecipeID: 42, RatingScore: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Favorite.changeset(%Favorite{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Favorite.changeset(%Favorite{}, @invalid_attrs)
    refute changeset.valid?
  end
end
