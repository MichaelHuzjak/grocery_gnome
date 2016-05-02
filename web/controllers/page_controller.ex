defmodule GroceryGnome.PageController do
  use GroceryGnome.Web, :controller
	plug GroceryGnome.Plug.Authenticate

	alias GroceryGnome.User
	alias GroceryGnome.Password

	alias GroceryGnome.Pantryitem
	alias GroceryGnome.Foodcatalog.Foodcatalog
  import Ecto.Query
	import Ecto.Date
	import Ecto.Changeset

  def login(conn, _params) do
		if is_nil(conn.assigns.current_user) do
			render(to: session_path(conn, :new))
		else
			 render conn, "homepage.html"
		end
  end

  def home(conn, _params) do
    render conn, "homepage.html"
  end

  def test(conn, _params) do
		mymap = %{}
		mapitems = Map.put(mymap, 0 , 5)
		
    render conn, "test.html", mapitems: mapitems
  end

	def change(conn, _params) do
		user = conn.assigns.current_user
    changeset = User.changeset(user)
		render(conn, "change.html", changeset: changeset)
  end

  def changepassword(conn, %{"user" => user_params}) do
		
    changeset = User.changeset(conn.assigns.current_user, user_params)
    if changeset.valid? do
			changeset = Password.generate_password(changeset)

			 case Repo.update(changeset) do
      {:ok, recipe} ->
        conn
        |> put_flash(:info, "User password updated successfully.")
        |> redirect(to: page_path(conn, :home))
      {:error, changeset} ->
        render(conn, "home.html")
    end
    else
      render conn, "change.html", changeset: changeset
    end
  end
	def expiration_notifications(conn) do
		userid = conn.assigns.current_user.id
		query = from p in Pantryitem, where: p.user_id == ^userid and p.expiration < date_add(^Ecto.Date.utc, 1, "week"), preload: [:foodcatalog]
    pantryitems = Repo.all(query)
	end
	
	def low_stock_notifications(conn) do
		userid = conn.assigns.current_user.id
		query = from p in Pantryitem, where: p.user_id == ^userid and p.monitor and  p.pantryquantity < p.baselevel, preload: [:foodcatalog]
    pantryitems = Repo.all(query)
	end


	def change_household(conn, _params) do
			#userid = conn.assigns.current_user.id
			#groceryitems = conn.params["household"]
			#newsize = groceryitems["size"]
			#changeset = User.changeset(conn.assigns.current_user, %{household: newsize})
			#put_change(changeset, :household, newsize)
			# case Repo.update(changeset) do
			#	 {:ok, recipe} ->
      #  conn
      #  |> put_flash(:info, "User Household updated successfully.")
      #  |> redirect(to: page_path(conn, :home))
			#	 {:error, changeset} ->
		redirect(to: groceryitem_path(conn, :index))
    #end				

	end
		
end
