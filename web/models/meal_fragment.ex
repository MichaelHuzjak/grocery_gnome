defmodule GroceryGnome.MealFragment do
  use GroceryGnome.Web, :model

  schema "mealfragments" do
    field :MealFragment_MealID, :integer
    field :MealFragment_RecipeID, :integer

    timestamps
  end

  @required_fields ~w(MealFragmentID MealFragment_MealID MealFragment_RecipeID)
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
