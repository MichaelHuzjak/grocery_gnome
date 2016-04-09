defmodule GroceryGnome.Mealplan do
  use GroceryGnome.Web, :model

  schema "mealplans" do
    field :breakfast, :string
    field :lunch, :string
    field :dinner, :string

    timestamps
  end

  @required_fields ~w(breakfast lunch dinner)
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
