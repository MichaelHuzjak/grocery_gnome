defmodule GroceryGnome.FoodCatalog do
  use GroceryGnome.Web, :model

  schema "food_catalog" do
    field :units, :string
    field :name, :string
    field :info, :string

    timestamps
  end

  @required_fields ~w(units name info)
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
