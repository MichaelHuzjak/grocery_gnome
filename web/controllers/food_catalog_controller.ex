defmodule GroceryGnome.FoodCatalogController do
  use GroceryGnome.Web, :controller

  alias GroceryGnome.FoodCatalog

  plug :scrub_params, "food_catalog" when action in [:create, :update]

  def index(conn, _params) do
    food_catalog = Repo.all(FoodCatalog)
    render(conn, "index.html", food_catalog: food_catalog)
  end

  def new(conn, _params) do
    changeset = FoodCatalog.changeset(%FoodCatalog{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"food_catalog" => food_catalog_params}) do
    changeset = FoodCatalog.changeset(%FoodCatalog{}, food_catalog_params)

    case Repo.insert(changeset) do
      {:ok, _food_catalog} ->
        conn
        |> put_flash(:info, "Food catalog created successfully.")
        |> redirect(to: food_catalog_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    food_catalog = Repo.get!(FoodCatalog, id)
    render(conn, "show.html", food_catalog: food_catalog)
  end

  def edit(conn, %{"id" => id}) do
    food_catalog = Repo.get!(FoodCatalog, id)
    changeset = FoodCatalog.changeset(food_catalog)
    render(conn, "edit.html", food_catalog: food_catalog, changeset: changeset)
  end

  def update(conn, %{"id" => id, "food_catalog" => food_catalog_params}) do
    food_catalog = Repo.get!(FoodCatalog, id)
    changeset = FoodCatalog.changeset(food_catalog, food_catalog_params)

    case Repo.update(changeset) do
      {:ok, food_catalog} ->
        conn
        |> put_flash(:info, "Food catalog updated successfully.")
        |> redirect(to: food_catalog_path(conn, :show, food_catalog))
      {:error, changeset} ->
        render(conn, "edit.html", food_catalog: food_catalog, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    food_catalog = Repo.get!(FoodCatalog, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(food_catalog)

    conn
    |> put_flash(:info, "Food catalog deleted successfully.")
    |> redirect(to: food_catalog_path(conn, :index))
  end
end
