defmodule GroceryGnome.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :AccountID, :integer
      add :AccountHolderFirstName, :string
      add :AccountHolderLastName, :string
      add :EmailAddress, :string
      add :Password, :string

      timestamps
    end

  end
end
