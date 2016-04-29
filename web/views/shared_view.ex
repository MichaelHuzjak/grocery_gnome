defmodule GroceryGnome.SharedView do
	use GroceryGnome.Web, :view

	alias GroceryGnome.Pantryitem
	alias GroceryGnome.Foodcatalog.Foodcatalog
  import Ecto.Query
	import Ecto.Date
	import Ecto.Repo
	
	def notifyExpiration(conn) do
		pantryitems = GroceryGnome.PageController.expiration_notifications conn
	end
end
