defmodule GroceryGnome.PantryController do
	use GroceryGnome.Web, :controller

	plug GroceryGnome.Plug.Authenticate

	# databases used 
	alias GroceryGnome.Foodcatalog
  plug :scrub_params, "foodcatalog" when action in [:create, :update]

	import Ecto.Query

	def index(conn, _params) do
				userid = conn.assigns.current_user.id

    foodcatalogs = Repo.all(from f in Foodcatalog, where: f.user_id == ^userid, select: f)
    #foodcatalogs = Repo.all(Foodcatalog)
    render(conn, "index.html", foodcatalogs: foodcatalogs)
  end

  def new(conn, _params) do
    changeset = Foodcatalog.changeset(%Foodcatalog{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"foodcatalog" => foodcatalog_params}) do
    #changeset = Foodcatalog.changeset(%Foodcatalog{}, foodcatalog_params)
    changeset = Foodcatalog.changeset(%Foodcatalog{}, %{foodname: foodcatalog_params["foodname"], foodquantity: foodcatalog_params["foodquantity"], foodunit: foodcatalog_params["foodunit"], user_id: conn.assigns.current_user.id})
    case Repo.insert(changeset) do
      {:ok, _foodcatalog} ->
        conn
        |> put_flash(:info, "Foodcatalog created successfully.")
        |> redirect(to: pantry_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
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
        |> redirect(to: pantry_path(conn, :show, foodcatalog))
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
    |> redirect(to: pantry_path(conn, :index))
  end
end
