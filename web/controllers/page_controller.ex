defmodule GroceryGnome.PageController do
  use GroceryGnome.Web, :controller
	plug GroceryGnome.Plug.Authenticate

	alias GroceryGnome.User
	alias GroceryGnome.Password

  def login(conn, _params) do
    render conn, "welcome.html"
  end

  def home(conn, _params) do
    render conn, "homepage.html"
  end

  def test(conn, _params) do
    render conn, "test.html"
  end

	def change(conn, _params) do
		user = conn.assigns.current_user
    changeset = User.changeset(user)
		render(conn, "change.html", changeset: changeset)
  end

  def changepassword(conn, %{"user" => user_params}) do
		
    changeset = User.changeset(conn.assigns.current_user, user_params)
    if changeset.valid? do
			changeset = Password.generate_password(changeset)

			 case Repo.update(changeset) do
      {:ok, recipe} ->
        conn
        |> put_flash(:info, "User password updated successfully.")
        |> redirect(to: page_path(conn, :home))
      {:error, changeset} ->
        render(conn, "home.html")
    end
    else
      render conn, "change.html", changeset: changeset
    end
  end

	# def new(conn, _params) do
	# 	changeset = User.changeset(%User{})
	# 	render conn, "new.html", changeset: changeset
	# end

end
