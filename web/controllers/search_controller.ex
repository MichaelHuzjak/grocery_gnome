defmodule GroceryGnome.SearchController do

	use GroceryGnome.Web, :controller

	def index(conn, _params) do
		render(conn, "index.html")
	end
	
	def recipe_search(conn, _params) do
		render(conn, "recipe_search.html")
	end

	def show(conn, params) do
		# IO.inspect params
		render(conn, "show.html", params)
	end
	
	def recipe_show(conn, params) do
		IO.inspect params
		render(conn, "show.html", params)
	end
	
end
