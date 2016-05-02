defmodule GroceryGnome.PantryitemController do
  use GroceryGnome.Web, :controller
	
	plug GroceryGnome.Plug.Authenticate

  alias GroceryGnome.Pantryitem
	alias GroceryGnome.Foodcatalog
		import Ecto.Query
import Ecto.Date

  plug :scrub_params, "foodcatalog" when action in [:create, :update]
  plug :scrub_params, "pantryitem" when action in [:create, :update]
#  plug :scrub_params, "foodcatalog" when action in [:new]

  def index(conn, _params) do
		userid = conn.assigns.current_user.id
		query = from p in Pantryitem, where: p.user_id == ^userid, preload: [:foodcatalog]
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
		date = pantryitem_params["expiration"]
		year = date["year"]
		month = date["month"]
		day = date["day"]
		edate = %Ecto.Date{year: String.to_integer(year), month: String.to_integer(month), day: String.to_integer(day)}
		monitor = pantryitem_params["monitor"]
		baselevel = pantryitem_params["baselevel"]
		changeset = Pantryitem.changeset(%Pantryitem{}, %{pantryquantity: pantryitem_params["pantryquantity"], expiration: edate, monitor: monitor, baselevel: baselevel, foodcatalog_id: id, user_id: conn.assigns.current_user.id})

    case Repo.insert(changeset) do
      {:ok, _pantryitem} ->
        conn
        |> put_flash(:info, "Pantryitem created successfully.")
        |> redirect(to: pantryitem_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, foodcatalog: foodcatalog)
    end
  end

  def show(conn, %{"id" => id}) do
    pantryitem = Repo.get!(Pantryitem, id)
    render(conn, "show.html", pantryitem: pantryitem)
  end

  def edit(conn, %{"id" => id}) do
    pantryitem = Repo.get!(Pantryitem, id)
		foodcatalog = Repo.get!(Foodcatalog, pantryitem.foodcatalog_id)

    changeset = Pantryitem.changeset(pantryitem,%{pantryquantity: pantryitem.pantryquantity, expiration: pantryitem.expiration, foodcatalog_id: pantryitem.foodcatalog_id, user_id: conn.assigns.current_user.id})
    render(conn, "edit.html", pantryitem: pantryitem, changeset: changeset, foodcatalog: foodcatalog)
  end

  def update(conn, %{"id" => id, "pantryitem" => pantryitem_params}) do
    pantryitem = Repo.get!(Pantryitem, id)
    #changeset = Pantryitem.changeset(pantryitem, pantryitem_params)
		foodcatalog = Repo.get!(Foodcatalog, pantryitem.foodcatalog_id)
		date = pantryitem_params["expiration"]
		year = date["year"]
		month = date["month"]
		day = date["day"]
		edate = %Ecto.Date{year: String.to_integer(year), month: String.to_integer(month), day: String.to_integer(day)}
		changeset = Pantryitem.changeset(pantryitem, %{pantryquantity: pantryitem_params["pantryquantity"], expiration: date, foodcatalog_id: pantryitem.foodcatalog_id, user_id: conn.assigns.current_user.id})
    case Repo.update(changeset) do
      {:ok, pantryitem} ->
        conn
        |> put_flash(:info, "Pantryitem updated successfully.")
        |> redirect(to: pantryitem_path(conn, :show, pantryitem))
      {:error, changeset} ->
        render(conn, "edit.html", pantryitem: pantryitem, changeset: changeset, foodcatalog: foodcatalog)
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

	def search(conn,_params) do

    render(conn, "pantryitemsearch.html")
	end

	def pantryitem_search(conn, _params) do
		search = conn.params["search"]
		query = search["query"]
		query = String.downcase(query)
		result = Repo.get_by(Foodcatalog, foodname: query)

		IO.inspect result

		if result != nil do
			name = String.split(result.foodname, " ")
			|> Enum.map(&String.capitalize(&1))
			|> (fn(f) -> (for x <- f, into: "", do: x <> " ") end).()
		end
		
		case result do
			nil ->
				query = String.capitalize(query)
				render(conn, "foodform.html", name: query)
			foodcatalog ->
				userid = conn.assigns.current_user.id
				pantryresult = Repo.get_by(Pantryitem, user_id: userid, foodcatalog_id: foodcatalog.id)
				case pantryresult do
					nil ->
						changeset = Pantryitem.changeset(%Pantryitem{})
						render(conn, "new.html", changeset: changeset, foodcatalog: foodcatalog, name: name)
					pantryitem ->
						foodcatalog = Repo.get!(Foodcatalog, pantryitem.foodcatalog_id)
						changeset = Pantryitem.changeset(pantryitem,%{pantryquantity: pantryitem.pantryquantity, expiration: pantryitem.expiration, foodcatalog_id: pantryitem.foodcatalog_id, user_id: conn.assigns.current_user.id})
						render(conn, "edit.html", pantryitem: pantryitem, changeset: changeset, foodcatalog: foodcatalog)
				end
			end
	end

	def newpantryfood(conn, _params) do
		pantryitem = conn.params["pantryitem"]
					result = Repo.get_by(Foodcatalog, foodname: pantryitem["foodname"])
					foodcatalogchangeset = Foodcatalog.changeset(%Foodcatalog{}, %{foodname: String.downcase( pantryitem["foodname"]), unit: pantryitem["unit"], info: pantryitem["info"]})
								case Repo.insert(foodcatalogchangeset) do
								  {:ok, _foodcatalog} ->
										date = pantryitem["expiration"]
										year = date["year"]
										month = date["month"]
										day = date["day"]
										edate = %Ecto.Date{year: String.to_integer(year), month: String.to_integer(month), day: String.to_integer(day)}
										changeset = Pantryitem.changeset(%Pantryitem{}, %{pantryquantity: pantryitem["pantryquantity"], expiration: date, foodcatalog_id: _foodcatalog.id, user_id: conn.assigns.current_user.id})
										case Repo.insert(changeset) do
											{:ok, _pantryitem} ->
												conn
												|> put_flash(:info, "Pantryitem created successfully.")
												|> redirect(to: pantryitem_path(conn, :index))
											{:error, changeset} ->
												render(conn, "new.html", changeset: changeset, foodcatalog: _foodcatalog, conn: @conn)
										end
								end
	end
	
end
