defmodule GroceryGnome.User do
  use GroceryGnome.Web, :model

  schema "users" do

    has_many :foods, GroceryGnome.Food

    field :username, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
		field :household, :integer
    timestamps
  end

  @required_fields ~w(username password password_confirmation household)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:username, on: GroceryGnome.Repo, downcase: true)
    |> validate_length(:password, min: 1)
    |> validate_length(:password_confirmation, min: 1)
    |> validate_confirmation(:password)
		|> validate_number(:household, greater_than: 0)

  end
end
