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

		resources "/grocery", GroceryitemController
		resources "/foodcatalog", FoodcatalogController
		resources "/pantry", PantryitemController
    resources "/recipes", RecipeController
    resources "/days", DayController

		get "/search", SearchController, :index
		get "/search/recipes", SearchController, :recipe_search
		post "/search/recipe/results", SearchController, :recipe_list
		get "/search/recipe/show/:id", SearchController, :recipe_show
		get "/search/recipe/similar/:id", SearchController, :recipe_similar

		get "/search/grocery", SearchController, :grocery_search
		post "/search/grocery/results", SearchController, :grocery_list

		get "/home", PageController, :home
		post "/home", PageController, :home
		get "/test", PageController, :test

		get "/kitchen", KitchenController, :index

		#get "/pantry", PantryitemController, :index

		#get "/grocerylist", GroceryitemController, :index

		get "/delete2", FoodcatalogController, :delete2
		get "/pantrydelete", PantryitemController, :pantrydelete
		get "/deleterecipe", RecipeController, :deleterecipe
		get "deletegrocery", GroceryitemController, :deletegrocery
		get "/movetopantry", GroceryitemController, :movetopantry
  end

  # Other scopes may use custom stacks.
  # scope "/api", GroceryGnome do
  #   pipe_through :api
  # end
end
