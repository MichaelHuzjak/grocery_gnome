defmodule GroceryGnome.PantryitemController do
  use GroceryGnome.Web, :controller
	
	plug GroceryGnome.Plug.Authenticate

  alias GroceryGnome.Pantryitem
	alias GroceryGnome.Foodcatalog
		import Ecto.Query


  plug :scrub_params, "foodcatalog" when action in [:create, :update]
  plug :scrub_params, "pantryitem" when action in [:create, :update]
#  plug :scrub_params, "foodcatalog" when action in [:new]

  def index(conn, _params) do
				userid = conn.assigns.current_user.id
		query = from p in Pantryitem, where: p.user_id == ^userid
    pantryitems = Repo.all(query)
		query2 = from f in Foodcatalog
		foodcatalogs = Repo.all(query2)
				
    render(conn, "index.html", pantryitems: pantryitems, foodcatalogs: foodcatalogs)
  end

  def new(conn, new_params) do
		foodcatalog = Repo.get!(Foodcatalog, new_params["foodcatalog"])
   changeset = Pantryitem.changeset(%Pantryitem{})
   render(conn, "new.html", changeset: changeset, foodcatalog: foodcatalog)
	end
	
	#def new(conn, %{"foodcatalog" => foodcatalog_params}) do
		#id = _params.foodcatalog.id
    #foodcatalog = Repo.get!(Foodcatalog, id)
	#	changeset = Pantryitem.changeset(%Pantryitem{})
	#	render(conn, "new.html", changeset: changeset)
	# end

	#def editfood(conn, %{"id" => id}) do
  #  foodcatalog = Repo.get!(Foodcatalog, id)
  #  changeset = Foodcatalog.changeset(foodcatalog)
  #  render(conn, "edit.html", foodcatalog: foodcatalog, changeset: changeset)
  #end

  def create(conn, %{"pantryitem" => pantryitem_params, "foodcatalog" => id}) do
		foodcatalog = Repo.get!(Foodcatalog, id)
		changeset = Pantryitem.changeset(%Pantryitem{}, %{pantryquantity: pantryitem_params["pantryquantity"], expiration: pantryitem_params["expiration"], foodcatalog_id: id, user_id: conn.assigns.current_user.id})

    case Repo.insert(changeset) do
      {:ok, _pantryitem} ->
        conn
        |> put_flash(:info, "Pantryitem created successfully.")
        |> redirect(to: pantryitem_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, foodcatalog: foodcatalog, conn: @conn)
    end
  end

  def show(conn, %{"id" => id}) do
    pantryitem = Repo.get!(Pantryitem, id)
    render(conn, "show.html", pantryitem: pantryitem)
  end

  def edit(conn, %{"id" => id}) do
    pantryitem = Repo.get!(Pantryitem, id)
    changeset = Pantryitem.changeset(pantryitem)
    render(conn, "edit.html", pantryitem: pantryitem, changeset: changeset)
  end

  def update(conn, %{"id" => id, "pantryitem" => pantryitem_params}) do
    pantryitem = Repo.get!(Pantryitem, id)
    changeset = Pantryitem.changeset(pantryitem, pantryitem_params)

    case Repo.update(changeset) do
      {:ok, pantryitem} ->
        conn
        |> put_flash(:info, "Pantryitem updated successfully.")
        |> redirect(to: pantryitem_path(conn, :show, pantryitem))
      {:error, changeset} ->
        render(conn, "edit.html", pantryitem: pantryitem, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pantryitem = Repo.get!(Pantryitem, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(pantryitem)

    conn
    |> put_flash(:info, "Pantryitem deleted successfully.")
    |> redirect(to: pantryitem_path(conn, :index))
  end

	def pantrydelete(conn, delete_param) do
		id = delete_param["pantryitem"]
    pantryitem = Repo.get!(Pantryitem, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(pantryitem)

    conn
    |> put_flash(:info, "Pantryitem deleted successfully.")
    |> redirect(to: pantryitem_path(conn, :index))
	end
	

end
