defmodule GroceryGnome.SearchController do

	use GroceryGnome.Web, :controller
	alias GroceryGnome.Spoonacular

	def index(conn, _params) do
		render(conn, "index.html")
	end
	
	def show(conn, params) do
		# IO.inspect params
		render(conn, "show.html", params)
	end
	
	def recipe_search(conn, _params) do
		render(conn, "recipe_search.html")
	end

	def recipe_list(conn, _params) do
		{:ok, resp} = Spoonacular.recipe_search conn.params["search"]
		%{"results" => results} = resp
		IO.inspect results
		render(conn, "recipe_list.html", recipes: results, uri: "https://spoonacular.com/recipeImages/")
	end

	def recipe_similar(conn, %{"id" => id}) do
		{:ok, resp} = Spoonacular.find_similar_recipes id
		IO.inspect resp
		render(conn, "recipe_list.html", recipes: resp, uri: "https://spoonacular.com/recipeImages/")
	end

	def recipe_show(conn, %{"id" => id}) do
		{:ok, resp} = GroceryGnome.Spoonacular.recipe_information id, false
		IO.inspect resp
		render(conn, "recipe_show.html", resp: resp, id: id)
	end

	def grocery_search(conn, _params) do
		render(conn, "grocery_search.html")
	end

	def grocery_list(conn, _params) do
		{:ok, resp} = Spoonacular.grocery_search conn.params["search"]
		IO.inspect resp["products"]
		render(conn, "grocery_list.html", products: resp["products"])
	end
end
