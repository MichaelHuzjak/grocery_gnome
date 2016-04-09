defmodule GroceryGnome.PantryItem do
  use GroceryGnome.Web, :model

  schema "pantry_items" do
    field :quantity, :float
    field :expiration, :map
    belongs_to :user, GroceryGnome.User
    belongs_to :food_catalog, GroceryGnome.FoodCatalog

    timestamps
  end

  @required_fields ~w(quantity expiration user_id food_catalog_id)
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
