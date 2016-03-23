defmodule GroceryGnome.Router do
  use GroceryGnome.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
    # plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GroceryGnome do
    pipe_through [:browser]

    get "/", PageController, :index
		delete "/logout", AuthController, :logout
		get "/test", PageController, :test
  end

  # Other scopes may use custom stacks.
  # scope "/api", GroceryGnome do
  #   pipe_through :api
  # end
end
