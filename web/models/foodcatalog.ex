defmodule GroceryGnome.Foodcatalog do
  use GroceryGnome.Web, :model

  schema "foodcatalogs" do
    field :foodname, :string
    field :foodquantity, :decimal
    field :foodunit, :string
    belongs_to :user, GroceryGnome.User

    timestamps
  end

  @required_fields ~w(foodname foodquantity foodunit user_id)
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
