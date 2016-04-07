defmodule GroceryGnome.PantryController do
	use GroceryGnome.Web, :controller

	plug GroceryGnome.Plug.Authenticate

	# databases used 
	alias GroceryGnome.Fooditem
	import Ecto.Query

	def index(conn, _params) do
		userid = conn.assigns.current_user.id
		render conn, "index.html"
	end
end
