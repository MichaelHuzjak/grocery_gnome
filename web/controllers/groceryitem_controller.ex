defmodule GroceryGnome.GroceryitemController do
  use GroceryGnome.Web, :controller

	plug GroceryGnome.Plug.Authenticate
	
  alias GroceryGnome.Groceryitem
	alias GroceryGnome.Pantryitem
	alias GroceryGnome.Foodcatalog

	import Ecto.Query

  plug :scrub_params, "groceryitem" when action in [:create, :update]

  def index(conn, _params) do
		userid = conn.assigns.current_user.id
		query = from p in Groceryitem, where: p.user_id == ^userid
    groceryitems = Repo.all(query)

		query2 = from f in Foodcatalog
		foodcatalogs = Repo.all(query2)
    render(conn, "index.html", groceryitems: groceryitems, foodcatalogs: foodcatalogs)

  end

  def new(conn, new_params) do
		foodcatalog = Repo.get!(Foodcatalog, new_params["foodcatalog"])
    changeset = Groceryitem.changeset(%Groceryitem{})
    render(conn, "new.html", changeset: changeset, foodcatalog: foodcatalog)
  end

  def create(conn, %{"groceryitem" => groceryitem_params, "foodcatalog" => id}) do
		foodcatalog = Repo.get!(Foodcatalog, id)
		changeset = Groceryitem.changeset(%Groceryitem{}, %{groceryquantity: groceryitem_params["groceryquantity"], foodcatalog_id: id, user_id: conn.assigns.current_user.id})
    case Repo.insert(changeset) do
      {:ok, _groceryitem} ->
        conn
        |> put_flash(:info, "Groceryitem created successfully.")
        |> redirect(to: groceryitem_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    groceryitem = Repo.get!(Groceryitem, id)
    render(conn, "show.html", groceryitem: groceryitem)
  end

  def edit(conn, %{"id" => id}) do
    groceryitem = Repo.get!(Groceryitem, id)
    changeset = Groceryitem.changeset(groceryitem)
    render(conn, "edit.html", groceryitem: groceryitem, changeset: changeset)
  end

  def update(conn, %{"id" => id, "groceryitem" => groceryitem_params}) do
    groceryitem = Repo.get!(Groceryitem, id)
    changeset = Groceryitem.changeset(groceryitem, groceryitem_params)

    case Repo.update(changeset) do
      {:ok, groceryitem} ->
        conn
        |> put_flash(:info, "Groceryitem updated successfully.")
        |> redirect(to: groceryitem_path(conn, :show, groceryitem))
      {:error, changeset} ->
        render(conn, "edit.html", groceryitem: groceryitem, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    groceryitem = Repo.get!(Groceryitem, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(groceryitem)

    conn
    |> put_flash(:info, "Groceryitem deleted successfully.")
    |> redirect(to: groceryitem_path(conn, :index))
  end

	def movetopantry(conn, params) do
		userid = conn.assigns.current_user.id
		query = from g in Groceryitem, where: g.user_id == ^userid
		groceryitems = Repo.all(query)

		for groceryitem <- groceryitems do
					#changeset = Pantryitem.changeset(%Pantryitem{}, %{pantryquantity: groceryitem.groceryquantity, expiration: "", foodcatalog_id: groceryitem.foodcatalog_id, user_id: conn.assigns.current_user.id})
			catalogid = groceryitem.foodcatalog_id
			result = Repo.get_by(Pantryitem, user_id: conn.assigns.current_user.id , foodcatalog_id: catalogid)

			case result do
				nil ->
					 changeset =  Pantryitem.changeset(%Pantryitem{}, %{pantryquantity: groceryitem.groceryquantity, expiration: "", foodcatalog_id: groceryitem.foodcatalog_id, user_id: conn.assigns.current_user.id})
					Repo.insert(changeset)
				pantryitem ->
				    changeset = Pantryitem.changeset(pantryitem, %{pantryquantity: pantryitem.pantryquantity + groceryitem.groceryquantity, expiration: pantryitem.expiration, foodcatalog_id: pantryitem.foodcatalog_id, user_id: conn.assigns.current_user.id})
					Repo.update(changeset)
			end
			
			Repo.delete!(groceryitem)
		end
		


    conn
    |> put_flash(:info, "Groceryitems moved successfully.")
    |> redirect(to: pantryitem_path(conn, :index))
	end

	def deletegrocery(conn, params) do
		id = params["groceryitem"]
    groceryitem = Repo.get!(Groceryitem, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(groceryitem)

    conn
    |> put_flash(:info, "Groceryitem deleted successfully.")
    |> redirect(to: groceryitem_path(conn, :index))
	end
	
	
	
end