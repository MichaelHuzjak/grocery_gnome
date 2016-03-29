defmodule GroceryGnome.ListController do
	use GroceryGnome.Web, :controller

	def index(conn, _params) do
		render conn, "grocerylist.html"
	end
end
