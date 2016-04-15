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

	  resources "/fooditems", FooditemController
		resources "/groceryitems", GroceryitemController
		resources "/foodcatalog", FoodcatalogController
		resources "/pantryitems", PantryitemController
    resources "/recipes", RecipeController
    resources "/days", DayController

		get "/search", SearchController, :index
		get "/search/recipes", SearchController, :recipe_search
		get "/search/results", SearchController, :show

		get "/home", PageController, :home
		post "/home", PageController, :home
		get "/test", PageController, :test

		get "/kitchen", KitchenController, :index

		get "/pantry", PantryController, :index

		get "/grocerylist", GrocerylistController, :index

		get "/delete2", FoodcatalogController, :delete2
		get "/pantrydelete", PantryitemController, :pantrydelete
  end

  # Other scopes may use custom stacks.
  # scope "/api", GroceryGnome do
  #   pipe_through :api
  # end
end
