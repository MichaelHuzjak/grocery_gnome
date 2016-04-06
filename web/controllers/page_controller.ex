defmodule GroceryGnome.PageController do
  use GroceryGnome.Web, :controller
	plug GroceryGnome.Plug.Authenticate

  def login(conn, _params) do
    render conn, "welcome.html"
  end

  def home(conn, _params) do
    render conn, "homepage.html"
  end

  def test(conn, _params) do
    render conn, "test.html"
  end

	# def new(conn, _params) do
	# 	changeset = User.changeset(%User{})
	# 	render conn, "new.html", changeset: changeset
	# end

end
