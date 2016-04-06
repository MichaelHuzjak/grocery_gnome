defmodule GroceryGnome.Meal do
  use GroceryGnome.Web, :model

  schema "meals" do
    field :Meal_RecipeID, :integer
    field :Meal_FoodPantryID, :integer

    timestamps
  end

  @required_fields ~w(MealID Meal_RecipeID Meal_FoodPantryID)
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
