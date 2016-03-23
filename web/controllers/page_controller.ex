defmodule GroceryGnome.PageController do
  use GroceryGnome.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
	def test(conn, _params) do 
		render conn, "test.html"
	end
	def splash(conn, _params) do
		render conn, "spash.html"
	end
end
