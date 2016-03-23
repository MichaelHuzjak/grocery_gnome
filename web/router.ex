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

		get "/kitchen", KitchenController, :index
		get "/pantry", PantryController, :index
		get "/grocerylist", ListController, :index
		get "/u/:user", UserController, :index

  end

  # Other scopes may use custom stacks.
  # scope "/api", GroceryGnome do
  #   pipe_through :api
  # end
end
