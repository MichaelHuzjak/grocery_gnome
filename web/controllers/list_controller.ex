defmodule GroceryGnome.GrocerylistController do
	use GroceryGnome.Web, :controller

	plug GroceryGnome.Plug.Authenticate
	alias GroceryGnome.Fooditem
	import Ecto.Query

  plug :scrub_params, "fooditem" when action in [:create, :update]

  def index(conn, _params) do
		userid = conn.assigns.current_user.id

    fooditems = Repo.all(from f in Fooditem, where: f.user_id == ^userid, select: f)
    render(conn, "grocerylist.html", fooditems: fooditems)
  end
end
