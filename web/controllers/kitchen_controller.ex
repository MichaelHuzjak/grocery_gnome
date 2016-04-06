defmodule GroceryGnome.KitchenController do
	use GroceryGnome.Web, :controller

	plug GroceryGnome.Plug.Authenticate

	def index(conn, _params) do
		render(conn, "kitchen.html")
	end
end
