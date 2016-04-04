defmodule GroceryGnome.PantryController do
	use GroceryGnome.Web, :controller

	plug GroceryGnome.Plug.Authenticate
	plug :action
	alias GroceryGnome.Fooditem		# this will have to whatever model is used for pantry
	import Ecto.Query

	def index(conn, _params) do
		userid = conn.assigns.current_user.id
		query = from f in Fooditems,
		where: f.user_id == ^userid,
		select: f
		
		items = Repo.all()
		render conn, "index.html"
	end
end
