defmodule GroceryGnome.Repo.Migrations.CreateFavorite do
  use Ecto.Migration

  def change do
    create table(:favorites) do
      add :FavoriteID, :integer
      add :Favorite_AccountID, references(:accounts)
      add :Favorite_RecipeID, :integer
      add :RatingScore, :integer

      timestamps
    end
		create index(:favorites, [:Favorite_AccountID])
  end
end
