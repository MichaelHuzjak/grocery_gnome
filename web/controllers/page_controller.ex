defmodule GroceryGnome.PageController do
  use GroceryGnome.Web, :controller

  def index(conn, _params) do
    render conn, "homepage.html"
  end

	def test(conn, _params) do
		render conn, "test.html"
	end
end
