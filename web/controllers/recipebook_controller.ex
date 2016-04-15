defmodule GroceryGnome.RecipebookController do
  use GroceryGnome.Web, :controller

  alias GroceryGnome.Recipebook

  plug :scrub_params, "recipebook" when action in [:create, :update]

  def index(conn, _params) do
    recipebooks = Repo.all(Recipebook)
    render(conn, "index.html", recipebooks: recipebooks)
  end


end
