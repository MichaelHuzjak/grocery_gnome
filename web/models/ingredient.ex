defmodule GroceryGnome.Ingredient do
  use GroceryGnome.Web, :model

  schema "ingredients" do
    field :IngredientID, :integer
    field :Ingredient_RecipeID, :integer
    field :Ingredient_FoodID, :integer

    timestamps
  end

  @required_fields ~w(IngredientID Ingredient_RecipeID Ingredient_FoodID)
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
