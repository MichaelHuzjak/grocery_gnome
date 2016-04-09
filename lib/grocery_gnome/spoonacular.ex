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
	# def classify_cuisine do
	# 	endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/cuisine"

	# 	HTTPotion.post(endpoint, [
	# 				headers: ["X-Mashape-Key": key,
	# 									"Content-Type": "application/x-www-form-urlencoded"],
	# 				body: Poison.encode(%{"ingredientList": "3 oz pork shoulder", 
	# 															"title": "Pork roast with green beans"})
	# 			])
	# end

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
	defp parse_params(params) do
 		Enum.join((for {k, v} <- params, do: to_string(k) <> "=" <> to_string(v)), "&")
	end
	
	# request times out, unsure why
	def summarize_recipe(id) do
		endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/#{id}/summary"

		HTTPotion.get(endpoint, [
					headers: dh
				])
		|> Map.get(:body)
		|> Poison.decode
	end

	def visualize_ingredients(params) do
		endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/visualizeIngredients"
		HTTPotion.post(get_params(endpoint, params), [
					header: ["Content-Type": "application/x-www-form-urlencoded"] ++ dh
				])
	end

end
# [%{one: "one"}, %{two: 2}]
