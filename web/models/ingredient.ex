defmodule GroceryGnome.Ingredient do
  use GroceryGnome.Web, :model

  schema "ingredients" do
    field :ingredientquantity, :float
    belongs_to :recipe, GroceryGnome.Recipe
    belongs_to :foodcatalog, GroceryGnome.Foodcatalog

    timestamps
  end

  @required_fields ~w(ingredientquantity recipe_id foodcatalog_id)
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
