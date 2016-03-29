defmodule GroceryGnome.PantryController do
	use GroceryGnome.Web, :controller

	def index(conn, _params) do
		render conn, "index.html"
	end
end
