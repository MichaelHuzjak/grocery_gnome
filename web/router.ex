defmodule GroceryGnome.Router do
  use GroceryGnome.Web, :router

  pipeline :browser do
		plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
		plug :put_secure_browser_headers
    plug :protect_from_forgery
   # plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GroceryGnome do
    pipe_through [:browser]

    get "/", SessionController, :new
    post "/login", SessionController, :create
    get "/logout", SessionController, :delete

    get "/registration", RegistrationController, :new
    post "/registration", RegistrationController, :create

		get "/home", PageController, :home
		post "/home", PageController, :home
		get "/test", PageController, :test

		get "/kitchen", KitchenController, :index

		get "/pantry", PantryController, :index

		get "/grocerylist", GrocerylistController, :index

		resources "/food_catalog", FoodCatalogController
		resources "/recipes", RecipeController
		resources "/days", DayController
		resources "/pantry_items", PantryItemController
  end

  # Other scopes may use custom stacks.
  # scope "/api", GroceryGnome do
  #   pipe_through :api
  # end
end
