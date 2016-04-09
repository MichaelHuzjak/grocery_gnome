defmodule GroceryGnome.Day do
  use GroceryGnome.Web, :model

  schema "days" do
    field :breakfast, {:array, :id}
    field :lunch, {:array, :id}
    field :dinner, {:array, :id}
    field :date, Ecto.Date
    belongs_to :user, GroceryGnome.User

    timestamps
  end

  @required_fields ~w(breakfast lunch dinner date user_id)
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
