defmodule GroceryGnome.ScheduleView do
  use GroceryGnome.Web, :view

	# terrible
	def fetch(id) do
		try do
			{:ok, resp} = GroceryGnome.Spoonacular.recipe_information(id,false)
			resp["title"]
		rescue
			HTTPotion.HTTPError -> ""
		end
	end

end
