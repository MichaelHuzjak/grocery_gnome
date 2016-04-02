defmodule GroceryGnome.FoodPantry do
  use GroceryGnome.Web, :model

  schema "foodpantries" do
    field :FoodPantryID, :integer
    field :FoodPantry_FoodID, :integer
    field :Quantity, :decimal
    field :Units, :string

    timestamps
  end

  @required_fields ~w(FoodPantryID FoodPantry_FoodID Quantity Units)
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
