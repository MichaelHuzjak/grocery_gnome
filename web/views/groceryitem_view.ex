defmodule GroceryGnome.GroceryitemView do
  use GroceryGnome.Web, :view
	alias GroceryGnome.Foodcatalog
	alias GroceryGnome.Repo
	import Ecto.Query

	def name_fetch(food_id) do
		result = Repo.get_by(Foodcatalog, id: food_id)
		result.foodname
	end
	
end
