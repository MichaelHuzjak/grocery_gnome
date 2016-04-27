defmodule GroceryGnome.Meal do
  use GroceryGnome.Web, :model

  schema "meals" do
    field :meal_type, :integer
    belongs_to :recipe, GroceryGnome.Recipe
    belongs_to :day, GroceryGnome.Day

    timestamps
  end

  @required_fields ~w(meal_type recipe_id day_id)
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
