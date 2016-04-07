defmodule GroceryGnome.Spoonacular do
	defp key do
		"o2vpkxCWj6mshXM1QuGyixd8L9Flp1tCOvejsn1xpmMUymypZy"
	end

	def classify_grocery(description) do
		endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/food/products/classify"
		{:ok, desc_json} = Poison.encode(description)
		HTTPotion.post(endpoint, [
					headers: ["X-Mashape-Key": key,
										"Content-Type": "application/json",
										"Accept": "application/json"],
					body: desc_json
				])
		|> Map.get(:body)
		|> Poison.decode
	end
end
