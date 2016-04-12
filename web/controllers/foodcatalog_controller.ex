defmodule GroceryGnome.FoodcatalogController do
  use GroceryGnome.Web, :controller

  alias GroceryGnome.Foodcatalog
	import Ecto.Query


  plug :scrub_params, "foodcatalog" when action in [:create, :update]

  def index(conn, _params) do
		#query = from f in Foodcatalog, where: f.foodname != "cheese"
		query = from f in Foodcatalog
		foodcatalogs = Repo.all(query)
    render(conn, "index.html", foodcatalogs: foodcatalogs)
  end

  def new(conn, _params) do
    changeset = Foodcatalog.changeset(%Foodcatalog{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"foodcatalog" => foodcatalog_params}) do
    changeset = Foodcatalog.changeset(%Foodcatalog{}, foodcatalog_params)

    case Repo.insert(changeset) do
      {:ok, _foodcatalog} ->
        conn
        |> put_flash(:info, "Foodcatalog created successfully.")
        |> redirect(to: foodcatalog_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, conn: @conn)
    end
  end

  def show(conn, %{"id" => id}) do
    foodcatalog = Repo.get!(Foodcatalog, id)
    render(conn, "show.html", foodcatalog: foodcatalog)
  end

  def edit(conn, %{"id" => id}) do
    foodcatalog = Repo.get!(Foodcatalog, id)
    changeset = Foodcatalog.changeset(foodcatalog)
    render(conn, "edit.html", foodcatalog: foodcatalog, changeset: changeset)
  end

  def update(conn, %{"id" => id, "foodcatalog" => foodcatalog_params}) do
    foodcatalog = Repo.get!(Foodcatalog, id)
    changeset = Foodcatalog.changeset(foodcatalog, foodcatalog_params)

    case Repo.update(changeset) do
      {:ok, foodcatalog} ->
        conn
        |> put_flash(:info, "Foodcatalog updated successfully.")
        |> redirect(to: foodcatalog_path(conn, :show, foodcatalog))
      {:error, changeset} ->
        render(conn, "edit.html", foodcatalog: foodcatalog, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    foodcatalog = Repo.get!(Foodcatalog, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(foodcatalog)

    conn
    |> put_flash(:info, "Foodcatalog deleted successfully.")
    |> redirect(to: foodcatalog_path(conn, :index))
  end

	
end
