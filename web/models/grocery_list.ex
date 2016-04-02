defmodule GroceryGnome.GroceryList do
  use GroceryGnome.Web, :model

  schema "grocerylists" do
    field :GroceryListID, :integer
    field :GroceryList_AccountID, :integer
    field :GroceryList_FoodID, :integer
    field :GroceryList_RecipeID, :string
    field :integer, :string

    timestamps
  end

  @required_fields ~w(GroceryListID GroceryList_AccountID GroceryList_FoodID GroceryList_RecipeID integer)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
