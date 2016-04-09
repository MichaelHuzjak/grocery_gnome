defmodule GroceryGnome.Recipe do
  use GroceryGnome.Web, :model

  schema "recipes" do
    field :ingredients, :map
    field :instructions, :string
    field :prep_time, :integer
    field :cook_time, :integer
    belongs_to :author, GroceryGnome.Author

    timestamps
  end

  @required_fields ~w(ingredients instructions prep_time cook_time)
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
