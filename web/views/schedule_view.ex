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

	def meal_schedule_date_select(form, field, opts \\ []) do
		builder = fn b ->
			~s"""
			Date: <%= b.(:day, []) %> / <%= b.(:month, []) / <%= b.(:hour, []) %>
			"""
		end
		builder = nil
		date_select(form, field, [builder: builder, default: Ecto.Date.utc] ++ opts)
	end
	
end
