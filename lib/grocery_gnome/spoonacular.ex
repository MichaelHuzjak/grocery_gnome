defmodule GroceryGnome.Spoonacular do
	defp key do
		"o2vpkxCWj6mshXM1QuGyixd8L9Flp1tCOvejsn1xpmMUymypZy"
	end

	defp dh do
		["X-Mashape-Key": key]
	end

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
end
# [%{one: "one"}, %{two: 2}]
