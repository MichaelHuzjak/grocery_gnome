defmodule GroceryGnome.PageController do
  use GroceryGnome.Web, :controller

  def index(conn, _params) do
    render conn, "welcome.html"
  end

end
