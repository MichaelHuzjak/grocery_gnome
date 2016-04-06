defmodule GroceryGnome.PantryController do
	use GroceryGnome.Web, :controller

	plug GroceryGnome.Plug.Authenticate
	plug :action

	def index(conn, _params) do
		render conn, "index.html"
	end
end
