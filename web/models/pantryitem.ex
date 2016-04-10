defmodule GroceryGnome.Pantryitem do
  use GroceryGnome.Web, :model

  schema "pantryitems" do
    field :pantryquantity, :float
    field :expiration, :string
    belongs_to :user, GroceryGnome.User
    belongs_to :foodcatalog, GroceryGnome.Foodcatalog

    timestamps
  end

  @required_fields ~w(pantryquantity expiration)
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
