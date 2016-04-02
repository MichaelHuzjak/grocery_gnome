defmodule GroceryGnome.RecipeCatalog do
  use GroceryGnome.Web, :model

  schema "recipecatalogs" do
    field :RecipeID, :integer
    field :RecipeName, :string
    field :PreparationTimeInMinues, :integer

    timestamps
  end

  @required_fields ~w(RecipeID RecipeName PreparationTimeInMinues)
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
