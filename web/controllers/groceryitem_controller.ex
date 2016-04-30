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
		query = from p in Groceryitem, where: p.user_id == ^userid, preload: [:foodcatalog]
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
					changeset =  Pantryitem.changeset(%Pantryitem{}, %{pantryquantity: groceryitem.groceryquantity, expiration: Ecto.Date.utc, foodcatalog_id: groceryitem.foodcatalog_id, user_id: conn.assigns.current_user.id})
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

	def search(conn,_params) do
    render(conn, "groceryitemsearch.html")
	end

	def groceryitem_search(conn, _params) do
		query = String.downcase(conn.params["search"]["query"])

		result = Repo.all(from p in Foodcatalog)

		rated = for x <- result, into: [] do
			{String.jaro_distance(x.foodname, query), x.foodname}
		end
		|> Enum.sort_by(&elem(&1,0), &>=/2)

		IO.inspect rated

		userid = conn.assigns.current_user.id

		cond do
			elem(hd(rated),0) == 1 ->
				changeset = Groceryitem.changeset(%Groceryitem{})
				render(conn, "new.html", changeset: changeset, foodcatalog: result)
			true ->
				redirect(conn, to: groceryitem_path(conn, :index))
		end

		# case result do
		# 	nil ->
		# 		query = String.capitalize(query)
		# 		render(conn, "foodform.html", name: query)
		# 	foodcatalog ->
		# 		userid = conn.assigns.current_user.id
		# 		query = Repo.get_by(Pantryitem, user_id: userid, foodcatalog_id: foodcatalog.id)
		# 		case result do
		# 			nil ->
		# 				changeset = Groceryitem.changeset(%Groceryitem{})
		# 				render(conn, "new.html", changeset: changeset, foodcatalog: foodcatalog)
		# 			groceryitem ->
		# 				#changeset = Groceryitem.changeset(	groceryitem)
		# 				#render(conn, "edit.html", groceryitem: 	groceryitem, changeset: changeset)
		# 				changeset = Groceryitem.changeset(%Groceryitem{})
		# 				render(conn, "new.html", changeset: changeset, foodcatalog: foodcatalog)
		# 		end
		# end
	end

	def newgroceryfood(conn, _params) do
		groceryitem = conn.params["groceryitem"]
		result = Repo.get_by(Foodcatalog, foodname: groceryitem["foodname"])
		foodcatalogchangeset = Foodcatalog.changeset(%Foodcatalog{}, %{foodname: String.downcase(groceryitem["foodname"]), unit: groceryitem["unit"], info: groceryitem["info"]})
		case Repo.insert(foodcatalogchangeset) do
			{:ok, _foodcatalog} ->
				changeset = Groceryitem.changeset(%Groceryitem{}, %{groceryquantity: groceryitem["groceryquantity"], foodcatalog_id: _foodcatalog.id, user_id: conn.assigns.current_user.id})
				case Repo.insert(changeset) do
					{:ok, _groceryitem} ->
						conn
						|> put_flash(:info, "Grocery Item created successfully.")
						|> redirect(to: groceryitem_path(conn, :index))
					{:error, changeset} ->
						render(conn, "new.html", changeset: changeset, foodcatalog: _foodcatalog, conn: @conn)
				end
		end
	end
	
	
end
