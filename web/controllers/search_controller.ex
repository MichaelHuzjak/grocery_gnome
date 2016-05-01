defmodule GroceryGnome.SearchController do	
	use GroceryGnome.Web, :controller
	alias GroceryGnome.Spoonacular

	plug GroceryGnome.Plug.Authenticate

	alias GroceryGnome.Recipe
	alias GroceryGnome.Foodcatalog
	alias GroceryGnome.Ingredient
	import Ecto.Query

	
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

	def recipe_add(conn, %{"id" => id}) do
		{:ok, recipe} = GroceryGnome.Spoonacular.recipe_information id, false
		IO.inspect recipe

		# create the recipe
    changeset = Recipe.changeset(%Recipe{}, %{recipe_title: recipe["title"], instructions: "Filler", prep_time: recipe["readyInMinutes"], cook_time: recipe["readyInMinutes"], serving_size: recipe["servings"], user_id: conn.assigns.current_user.id})

    case Repo.insert(changeset) do
      {:ok, _recipe} ->
				# Since change was inserted into the database ok
				recipe_id = _recipe.id
				# Removing keywords from parameter map
				for ingredient <- recipe["extendedIngredients"] do
					result = Repo.get_by(Foodcatalog, foodname: ingredient["name"])
					case result do
						nil ->
							foodcatalogchangeset = Foodcatalog.changeset(%Foodcatalog{}, %{foodname: ingredient["name"], unit: ingredient["unit"], info: ingredient["aisle"]})
							case Repo.insert(foodcatalogchangeset) do
								      {:ok, _foodcatalog} ->
									ingredient_changeset = Ingredient.changeset(%Ingredient{}, %{ foodcatalog_id: _foodcatalog.id, ingredientquantity: ingredient["amount"], recipe_id: recipe_id})
									Repo.insert(ingredient_changeset)
								end
						foodcatalog ->
									ingredient_changeset = Ingredient.changeset(%Ingredient{}, %{ foodcatalog_id: foodcatalog.id, ingredientquantity: ingredient["amount"], recipe_id: recipe_id})
									Repo.insert(ingredient_changeset)
					end
				end
				
        conn
        |> put_flash(:info, "Recipe created successfully. #{recipe_id}")
        |> redirect(to: recipe_path(conn, :index))
      {:error, changeset} ->
				conn
				|> redirect(to: recipe_path(conn, :index))
    end
		#conn
    # |> redirect(to: recipe_path(conn, :index))
	end
	
	def grocery_search(conn, _params) do
		render(conn, "grocery_search.html", conn: conn)
	end

	def grocery_list(conn, _params) do
		{:ok, resp} = Spoonacular.grocery_search conn.params["search"]
		IO.inspect resp["products"]
		render(conn, "grocery_list.html", products: resp["products"])
	end

	def grocery_show(conn, %{"id" => id}) do
		{:ok, resp} = GroceryGnome.Spoonacular.product_information id
		IO.inspect resp
		render(conn, "grocery_show.html", resp: resp, id: id)
	end

end
