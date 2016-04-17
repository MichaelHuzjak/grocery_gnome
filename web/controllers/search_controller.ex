defmodule GroceryGnome.SearchController do

	use GroceryGnome.Web, :controller
	alias GroceryGnome.Spoonacular

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
	
	def recipe_show(conn, _params) do
		{:ok, resp} = Spoonacular.recipe_search conn.params["search"]
		%{"baseUri" => uri,
			"results" => results} = resp
		IO.inspect uri
		IO.inspect results
		render(conn, "show.html", recipes: results, uri: uri)
	end
	
end
