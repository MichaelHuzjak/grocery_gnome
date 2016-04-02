defmodule GroceryGnome.Account do
  use GroceryGnome.Web, :model

  schema "accounts" do
    field :AccountID, :integer
    field :AccountHolderFirstName, :string
    field :AccountHolderLastName, :string
    field :EmailAddress, :string
    field :Password, :string

    timestamps
  end

  @required_fields ~w(AccountID AccountHolderFirstName AccountHolderLastName EmailAddress Password)
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
