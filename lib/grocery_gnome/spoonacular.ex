defmodule GroceryGnome.Spoonacular do

	# The chosen API key. (This one is mine so if you it should work out of the box already)
	defp key do
		"o2vpkxCWj6mshXM1QuGyixd8L9Flp1tCOvejsn1xpmMUymypZy"
	end

	# default headers to be used in various api requests
	defp dh do
		["X-Mashape-Key": key]
	end

	@doc "supplied a %{\"title\": some_string} the api will deduce ingredients"
	def classify_grocery(description) do
		endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/food/products/classify"
		{:ok, desc_json} = Poison.encode(description)
		HTTPotion.post(endpoint, [
					headers: ["Content-Type": "application/json",
										"Accept": "application/json"] ++ dh,
					body: desc_json
				])
		|> Map.get(:body)
		|> Poison.decode
	end

	### this isn't working yet. supplying parameters have me stumped ...
	def classify_cuisine(ingredient_list, title) do
		endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/cuisine"

		HTTPotion.post(endpoint, [
					headers: ["X-Mashape-Key": key,
										"Content-Type": "application/x-www-form-urlencoded"],
					body: parse_params%{"ingredientList": ingredient_list,
															"title": title}
				])
		|> Map.get(:body)
		|> Poison.decode
	end

	def map_grocery_ingredients(mapping) do
		endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/food/ingredients/map"
		{:ok, map_json} = Poison.encode(mapping)
		HTTPotion.post(endpoint, [
					headers: ["Content-Type": "application/json",
										"Accept": "application/json"] ++ dh,
					body: map_json
				])
		|> Map.get(:body)
		|> Poison.decode
	end

	def caloried_meal_plan(daily_calories, time_frame) do
		# time_frame = "week" or "day"
		endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/mealplans/generate"
		HTTPotion.get(get_params(endpoint, [targetCalories: daily_calories, timeFrame: time_frame]), [
					headers: dh
				])
		|> Map.get(:body)
		|> Poison.decode
	end

	# constructs the full url with params (for get requests mainly)
	def get_params(url, params) do
		"#{url}?#{parse_params(params)}"
	end

	# parses just the parameters so they're in the standard format
	def parse_params(params) do
		(for {k, v} <- params, do: to_string(k) <> "=" <>
			String.replace(to_string(v), " ", "+"))
 		|> Enum.join("&")
	end

	# request times out, unsure why
	def summarize_recipe(id) do
		endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/#{id}/summary"
		HTTPotion.get(endpoint, [
					headers: dh
				])
		# |> Map.get(:body)
		# |> Poison.decode
	end

	def visualize_ingredients(params) do
		endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/visualizeIngredients"
		HTTPotion.post(endpoint, [
					headers: ["Content-Type": "application/x-www-form-urlencoded"] ++ dh,
					body: parse_params(params)
				])
		|> Map.get(:body)
	end

	def quick_answer(question) do
		endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/quickAnswer"
		HTTPotion.get(get_params(endpoint, q: question), [
					headers: dh
				])
		|> Map.get(:body)
		|> Poison.decode
	end

	def visualize_nutrition(defaultCss, ingredientList, servings) do
		endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/visualizeNutrition"
		HTTPotion.post(endpoint, [
					headers: ["Content-Type": "application/x-www-form-urlencoded"] ++ dh,
					body: parse_params(defaultCss: defaultCss, ingredientList: ingredientList, servings: servings)
				])
		|> Map.get(:body)
		# |> Poison.decode
	end

	def analyze_recipe_query(query) do
		endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/queries/analyze"
		HTTPotion.get(get_params(endpoint, q: query), [
					headers: ["Accept": "application/json"] ++ dh
				])
		|> Map.get(:body)
		|> Poison.decode
	end

	def parse_ingredients(ingredientList, servings) do
		endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/parseIngredients"
		HTTPotion.post(endpoint, [
					headers: ["Content-Type": "application/x-www-form-urlencoded"] ++ dh,
					body: parse_params(ingredientList: ingredientList, servings: servings)
				])
		|> Map.get(:body)
		|> Poison.decode
	end

	def autocomplete_ingredient(query) do
		endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/food/ingredients/autocomplete"
		HTTPotion.get(get_params(endpoint, query: query), [
					headers: dh
				])
		|> Map.get(:body)
		|> Poison.decode
	end

	@doc "Search through hundreds of thousands of recipes using advanced filtering and ranking. NOTE: Since this method combines three other functionalities, each request counts as 3 requests.

PARAMETERS:
cuisine (STRING) -- The cuisine(s) of the recipes. One or more (comma separated) of the following: african, chinese, japanese, korean, vietnamese, thai, indian, british, irish, french, italian, mexican, spanish, middle eastern, jewish, american, cajun, southern, greek, german, nordic, eastern european, caribbean, or latin american.

diet (STRING) -- The diet to which the recipes must be compliant. Possible values are: pescetarian, lacto vegetarian, ovo vegetarian, vegan, paleo, primal, and vegetarian.

excludeIngredients (STRING) -- An comma-separated list of ingredients that must not be contained in the recipes.

fillIngredients (BOOLEAN) -- Add information about the used and missing ingredients in each recipe.

includeIngredients (STRING) -- A comma-separated list of ingredients that should/must be contained in the recipe.

intolerances (STRING) -- A comma-separated list of intolerances. All found recipes must not have ingredients that could cause problems for people with one of the given tolerances. Possible values are: dairy, egg, gluten, peanut, sesame, seafood, shellfish, soy, sulfite, tree nut, and wheat.

limitLicense (BOOLEAN) -- Whether the recipes should have an open license that allows for displaying with proper attribution.

maxCalories, maxCarbs, maxFat, maxProtein, minCalories, minCarbs, minFat, minProtein (NUMBER) -- Setting limits on named macronutrients.

number (NUMBER) -- The number of results to return (between 1 and 100).

offset (NUMBER) -- The number of results to skip (between 0 and 900).

query (STRING) -- The recipe search query.

ranking (NUMBER) -- Whether to maximize used ingredients (1) or minimize missing ingredients (2) first.

type (STRING) -- The type of the recipes. One of the following: main course, side dish, dessert, appetizer, salad, bread, breakfast, soup, beverage, sauce, or drink."
	def complex_recipe_search(parameters) do
		endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/searchComplex"
		HTTPotion.get(get_params(endpoint, parameters), [
					headers: dh
				])
		|> Map.get(:body)
		|> Poison.decode
	end

	@doc "Parameters are:
fillIngredients (BOOLEAN) -- Add information about the used and missing ingredients in each recipe
ingredients (STRING) -- A comma separated list of ingredients that the recipes should contain
limitLicense (BOOLEAN) -- Whether to only show recipes with an attribution license.
number (NUMBER) -- Amount of recipes to return.
ranking (NUMBER) -- Whether to maximize used ingredients (1) or minimize missing ingredients (2) first."
	def find_by_ingredients(parameters) do
		endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/findByIngredients"
		HTTPotion.get(get_params(endpoint, parameters), [
					headers: ["Accept": "application/json"] ++ dh
				])
		|> Map.get(:body)
		|> Poison.decode
	end

	@doc "Finds recipes by limits in macronutrients"
	def find_by_nutrients(parameters) do
		endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/findByNutrients"
		HTTPotion.get(get_params(endpoint, parameters), [
					headers: dh
				])
		|> Map.get(:body)
		|> Poison.decode
	end

	def search_grocery(num_results, offset, query) do
		endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/food/products/search"
		HTTPotion.get(
			get_params(endpoint,
								 number: num_results, offset: offset, query: query), [
				headers: dh
			])
		|> Map.get(:body)
		|> Poison.decode
	end

	def search_recipes(parameters) do
		endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/search"
		HTTPotion.get(get_params(endpoint, parameters), [
					headers: dh
				])
		|> Map.get(:body)
		|> Poison.decode
	end

	def product_information(id) do
		endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/food/products/#{id}"
		HTTPotion.get(endpoint, [
					headers: dh
				])
		|> Map.get(:body)
		|> Poison.decode
	end

	def recipe_information(id, nutrition_p) do
		endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/#{id}/information"
		HTTPotion.get(get_params(endpoint, includeNutrition: nutrition_p), [
			headers: dh
				])
		|> Map.get(:body)
		|> Poison.decode
	end

end
# [%{one: "one"}, %{two: 2}]
