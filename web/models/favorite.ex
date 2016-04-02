defmodule GroceryGnome.Favorite do
  use GroceryGnome.Web, :model

  schema "favorites" do
    field :FavoriteID, :integer
    field :Favorite_AccountID, :integer
    field :Favorite_RecipeID, :integer
    field :RatingScore, :integer

    timestamps
  end

  @required_fields ~w(FavoriteID Favorite_AccountID Favorite_RecipeID RatingScore)
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
