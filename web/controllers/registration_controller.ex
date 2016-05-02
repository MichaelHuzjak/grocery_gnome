defmodule GroceryGnome.RegistrationController do
  use GroceryGnome.Web, :controller

  alias GroceryGnome.Password

  plug :scrub_params, "user" when action in [:create]

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, changeset: changeset
  end


  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
    if changeset.valid? do
      new_user = Password.generate_password_and_store_user(changeset)

      conn
        |> put_flash(:info, "Successfully registered")
        |> redirect(to: session_path(conn, :new))
    else
			conn
			|> put_flash(:error, "Failed to register")
			  |> redirect(to: session_path(conn, :new))

    end
  end
    

end
