defmodule GroceryGnome.Repo.Migrations.CreateFavorite do
  use Ecto.Migration

  def change do
    create table(:favorites) do
      add :FavoriteID, :integer
      add :Favorite_AccountID, :integer
      add :Favorite_RecipeID, :integer
      add :RatingScore, :integer

      timestamps
    end

  end
end
