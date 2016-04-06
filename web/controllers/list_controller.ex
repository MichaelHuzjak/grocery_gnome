defmodule GroceryGnome.GrocerylistController do
	use GroceryGnome.Web, :controller

	plug GroceryGnome.Plug.Authenticate
	plug :action									# what does this line do?
	
	def index(conn, _params) do
		

		render conn, "grocerylist.html"
	end
end
