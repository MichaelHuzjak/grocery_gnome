defmodule GroceryGnome.KitchenController do
	use GroceryGnome.Web, :controller

	def index(conn, _params) do
		render conn, "kitchen.html"
	end
end
