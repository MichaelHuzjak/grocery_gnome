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
		get "/search/recipe/recipe_add/:id", SearchController, :recipe_add
		get "/search/recipe/similar/:id", SearchController, :recipe_similar

		get "/search/grocerylist", SearchController, :grocery_search
		post "/search/grocerylist/results", SearchController, :grocery_list
		get "/search/grocerylist/show/:id", SearchController, :grocery_show

		post "/search/pantry/query", PantryitemController, :pantryitem_search
		post "/search/pantry/new", PantryitemController, :newpantryfood
		get "/search/pantry", PantryitemController, :search

		post "/search/grocery/query", GroceryitemController, :groceryitem_search
		post "/search/grocery/new", GroceryitemController, :newgroceryfood
		get "/search/grocery", GroceryitemController, :search

		get "/schedule", ScheduleController, :index
		post "/schedule/gen", ScheduleController, :generate
		post "/schedule/gen2dat",ScheduleController, :generatetodatabase
		get "/schedule/delete/:id", ScheduleController, :delete
		get "/schedule/new", ScheduleController, :new
		post "/schedule/new_day", ScheduleController, :new_day
		post "/schedule/create", ScheduleController, :create

		get "/home", PageController, :home
		post "/home", PageController, :home
		get "/test", PageController, :test

		get "/kitchen", KitchenController, :index

		get "/recipebook", RecipeController, :recipebook

		#get "/pantry", PantryitemController, :index

		#get "/grocerylist", GroceryitemController, :index

		get "/delete2", FoodcatalogController, :delete2
		get "/pantrydelete", PantryitemController, :pantrydelete
		get "/deleterecipe", RecipeController, :deleterecipe

		post "/move", GroceryitemController, :move
		get "/deletegrocery", GroceryitemController, :deletegrocery
		get "/movetopantry", GroceryitemController, :movetopantry
		get "/changepassword", PageController, :change
		post "/changepassword", PageController, :changepassword
		put "/changepassword", PageController, :changepassword
		get "/ensureschedule", ScheduleController, :ensure_schedule
		get "/shoppinglist", GroceryitemController, :shop_by_recipe
		get "/shoppinglist/show/:id", GroceryitemController, :show_recipe
		get "/shoppinglist/togrocery/:id", GroceryitemController, :recipe_to_grocery
		get "/household", PageController, :household
		post "/change_household", PageController, :change_household
  end

  # Other scopes may use custom stacks.
  # scope "/api", GroceryGnome do
  #   pipe_through :api
  # end
end
