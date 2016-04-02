defmodule GroceryGnome.AccountTest do
  use GroceryGnome.ModelCase

  alias GroceryGnome.Account

  @valid_attrs %{AccountHolderFirstName: "some content", AccountHolderLastName: "some content", AccountID: 42, EmailAddress: "some content", Password: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Account.changeset(%Account{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Account.changeset(%Account{}, @invalid_attrs)
    refute changeset.valid?
  end
end
