defmodule GroceryGnome.RecipeController do
  use GroceryGnome.Web, :controller

		plug GroceryGnome.Plug.Authenticate

		alias GroceryGnome.Recipe
		alias GroceryGnome.Foodcatalog
		import Ecto.Query

  plug :scrub_params, "recipe" when action in [:create, :update]

  def index(conn, _params) do
		userid = conn.assigns.current_user.id
		query = from p in Recipe, where: p.user_id == ^userid
    recipes = Repo.all(query)
    render(conn, "index.html", recipes: recipes)
  end

  def recipebook(conn, _params) do
    render(conn, "recipebook.html")
  end

  def new(conn, _params) do
    changeset = Recipe.changeset(%Recipe{})
		query = from f in Foodcatalog
		foodcatalogs = Repo.all(query)
    render(conn, "new.html", changeset: changeset, foodcatalogs: foodcatalogs)
  end

  def create(conn, %{"recipe" => recipe_params}) do
    changeset = Recipe.changeset(%Recipe{}, %{ instructions: recipe_params["instructions"], prep_time: recipe_params["prep_time"], cook_time: recipe_params["cook_time"], user_id: conn.assigns.current_user.id})

    case Repo.insert(changeset) do
      {:ok, _recipe} ->
        conn
        |> put_flash(:info, "Recipe created successfully.")
        |> redirect(to: recipe_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    recipe = Repo.get!(Recipe, id)
    render(conn, "show.html", recipe: recipe)
  end

  def edit(conn, %{"id" => id}) do
    recipe = Repo.get!(Recipe, id)
    changeset = Recipe.changeset(recipe)
    render(conn, "edit.html", recipe: recipe, changeset: changeset)
  end

  def update(conn, %{"id" => id, "recipe" => recipe_params}) do
    recipe = Repo.get!(Recipe, id)
    changeset = Recipe.changeset(recipe, recipe_params)

    case Repo.update(changeset) do
      {:ok, recipe} ->
        conn
        |> put_flash(:info, "Recipe updated successfully.")
        |> redirect(to: recipe_path(conn, :show, recipe))
      {:error, changeset} ->
        render(conn, "edit.html", recipe: recipe, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    recipe = Repo.get!(Recipe, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(recipe)

    conn
    |> put_flash(:info, "Recipe deleted successfully.")
    |> redirect(to: recipe_path(conn, :index))
  end

	def deleterecipe(conn, params) do
		id = params["recipe"]
    recipe = Repo.get!(Recipe, id)
    Repo.delete!(recipe)

    conn
    |> put_flash(:info, "Recipe deleted successfully.")
    |> redirect(to: recipe_path(conn, :index))
	end
	
				
end
