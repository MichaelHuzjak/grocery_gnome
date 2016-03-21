defmodule GroceryGnome.Router do
  use GroceryGnome.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
    # plug :put_secure_browser_headers
  end

	# plug looks for a guardian token in session in default location # what is the default location
	# attempt to load resource found in the jwt
	# if no jwt in default location, does nothing
	# pipeline :browser_auth do
	# 	plug Guardian.Plug.Verify
	# 	plug Guardian.Plug.LoadResource
	# end
	
	# # admin pipeline.
	# pipeline :admin_browser_auth do
	# 	plug Guardian.Plug.VerifySession, key: :admin
	# 	plug Guardian.Plug.LoadResource, key: :admin
	# end

	# # impersonation plug
	# pipeline :impersonation_browser_auth do
	# 	plug Guardian.Plug.VerifySession, key: :admin
	# end

	

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GroceryGnome do
    pipe_through [:browser]

    get "/", PageController, :index
		delete "/logout", AuthController, :logout
		get "/test", PageController, :test

		# resources "/users", UserController
		# resources "/authorizations", AuthorizationController
		# resources "/tokens", TokenController

		# get "/private", PrivatePageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", GroceryGnome do
  #   pipe_through :api
  # end
end
