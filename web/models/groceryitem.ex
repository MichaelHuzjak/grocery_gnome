defmodule GroceryGnome.Groceryitem do
  use GroceryGnome.Web, :model

  schema "groceryitems" do
    field :groceryquantity, :float
    belongs_to :user, GroceryGnome.User
    belongs_to :foodcatalog, GroceryGnome.Foodcatalog

    timestamps
  end

  @required_fields ~w(groceryquantity user_id foodcatalog_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
						|> unique_constraint(:foodcatalog, name: :pantry_item_index, on: GroceryGnome.Repo)
  end
end
