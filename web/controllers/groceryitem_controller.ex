defmodule GroceryGnome.GroceryitemController do
  use GroceryGnome.Web, :controller

	plug GroceryGnome.Plug.Authenticate
	
  alias GroceryGnome.Groceryitem
	alias GroceryGnome.Recipe
	alias GroceryGnome.Ingredient
	alias GroceryGnome.Pantryitem
	alias GroceryGnome.Foodcatalog
	import Ecto.Query

  plug :scrub_params, "groceryitem" when action in [:create, :update]

  def index(conn, _params) do
		userid = conn.assigns.current_user.id
		query = from p in Groceryitem, where: p.user_id == ^userid, preload: [:foodcatalog]
    groceryitems = Repo.all(query)

		query2 = from f in Foodcatalog
		foodcatalogs = Repo.all(query2)
    render(conn, "index.html", groceryitems: groceryitems, foodcatalogs: foodcatalogs)

  end

  def new(conn, new_params) do
		foodcatalog = Repo.get!(Foodcatalog, new_params["foodcatalog"])
    changeset = Groceryitem.changeset(%Groceryitem{})
    render(conn, "new.html", changeset: changeset, foodcatalog: foodcatalog)
  end

  def create(conn, %{"groceryitem" => groceryitem_params, "foodcatalog" => id}) do
		foodcatalog = Repo.get!(Foodcatalog, id)
		changeset = Groceryitem.changeset(%Groceryitem{}, %{groceryquantity: groceryitem_params["groceryquantity"], foodcatalog_id: id, user_id: conn.assigns.current_user.id})
    case Repo.insert(changeset) do
      {:ok, _groceryitem} ->
        conn
								|> put_flash(:info, "Groceryitem created successfully.")
																|> redirect(to: groceryitem_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    groceryitem = Repo.get!(Groceryitem, id)
    render(conn, "show.html", groceryitem: groceryitem)
  end

  def edit(conn, %{"id" => id}) do
    groceryitem = Repo.get!(Groceryitem, id)
    changeset = Groceryitem.changeset(groceryitem)
    render(conn, "edit.html", groceryitem: groceryitem, changeset: changeset)
  end

  def update(conn, %{"id" => id, "groceryitem" => groceryitem_params}) do
    groceryitem = Repo.get!(Groceryitem, id)
    changeset = Groceryitem.changeset(groceryitem, groceryitem_params)

    case Repo.update(changeset) do
      {:ok, groceryitem} ->
        conn
								|> put_flash(:info, "Groceryitem updated successfully.")
																|> redirect(to: groceryitem_path(conn, :show, groceryitem))
      {:error, changeset} ->
        render(conn, "edit.html", groceryitem: groceryitem, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    groceryitem = Repo.get!(Groceryitem, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(groceryitem)

    conn
				|> put_flash(:info, "Groceryitem deleted successfully.")
								|> redirect(to: groceryitem_path(conn, :index))
  end

	def move(conn, params) do
		groceryitems = conn.params["movelist"]
		case groceryitems do
			nil ->	
				conn
				|> put_flash(:info, "Groceryitems moved successfully.")
				|> redirect(to: pantryitem_path(conn, :index))
			groceryitems ->
				for {key,value} <- groceryitems do
					if value == "true" do
						groceryitem = Repo.get(Groceryitem, key)
						catalogid = groceryitem.foodcatalog_id
						result = Repo.get_by(Pantryitem, user_id: conn.assigns.current_user.id , foodcatalog_id: catalogid)
						case result do
							nil ->
								changeset =  Pantryitem.changeset(%Pantryitem{}, %{pantryquantity: groceryitem.groceryquantity,  monitor: "false", baselevel: 0, foodcatalog_id: groceryitem.foodcatalog_id, user_id: conn.assigns.current_user.id})
								Repo.insert(changeset)
							pantryitem ->
								changeset = Pantryitem.changeset(pantryitem, %{pantryquantity: pantryitem.pantryquantity + groceryitem.groceryquantity,
																															 monitor: pantryitem.monitor == nil,
																															 baselevel: pantryitem.baselevel == nil,
																															 expiration: pantryitem.expiration, foodcatalog_id: pantryitem.foodcatalog_id, user_id: conn.assigns.current_user.id})
								Repo.update(changeset)
						end
						Repo.delete!(groceryitem)
					end
				end
				conn
				|> put_flash(:info, "Groceryitems moved successfully.")
				|> redirect(to: pantryitem_path(conn, :index))
		end
	end

	def deletegrocery(conn, params) do
		id = params["groceryitem"]
    groceryitem = Repo.get!(Groceryitem, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(groceryitem)

    conn
				|> put_flash(:info, "Groceryitem deleted successfully.")
								|> redirect(to: groceryitem_path(conn, :index))
	end

	def deletegrocery(conn, params) do
		id = params["groceryitem"]
    groceryitem = Repo.get!(Groceryitem, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(groceryitem)

    conn
				|> put_flash(:info, "Groceryitem deleted successfully.")
								|> redirect(to: groceryitem_path(conn, :index))
	end

	def search(conn,_params) do
    render(conn, "groceryitemsearch.html")
	end

	def groceryitem_search(conn, _params) do
		search = conn.params["search"]
		query = search["query"]
		query = String.downcase(query)
		result = Repo.get_by(Foodcatalog, foodname: query)

		case result do
			nil ->
				query = String.capitalize(query)
				render(conn, "foodform.html", name: query)
			foodcatalog ->
				userid = conn.assigns.current_user.id
				groceryresult = Repo.get_by(Groceryitem, user_id: userid, foodcatalog_id: foodcatalog.id)
				case groceryresult do
					nil ->
						changeset = Groceryitem.changeset(%Groceryitem{})
						render(conn, "new.html", changeset: changeset, foodcatalog: foodcatalog)
					groceryitem ->
						changeset = Groceryitem.changeset(groceryitem)
						render(conn, "edit.html", groceryitem: groceryitem, changeset: changeset)
				end
			end
	end

	def newgroceryfood(conn, _params) do
		groceryitem = conn.params["groceryitem"]
					result = Repo.get_by(Foodcatalog, foodname: groceryitem["foodname"])
					foodcatalogchangeset = Foodcatalog.changeset(%Foodcatalog{}, %{foodname: String.downcase(groceryitem["foodname"]), unit: groceryitem["unit"], info: groceryitem["info"]})
								case Repo.insert(foodcatalogchangeset) do
								  {:ok, foodcatalog} ->
										changeset = Groceryitem.changeset(%Groceryitem{}, %{groceryquantity: groceryitem["groceryquantity"], foodcatalog_id: foodcatalog.id, user_id: conn.assigns.current_user.id})
										case Repo.insert(changeset) do
											{:ok, _groceryitem} ->
												conn
												|> put_flash(:info, "Grocery Item created successfully.")
												|> redirect(to: groceryitem_path(conn, :index))
											{:error, changeset} ->
												render(conn, "new.html", changeset: changeset, foodcatalog: foodcatalog, conn: @conn)
										end
								end
	end

	def shop_by_recipe(conn, _params) do
		userid = conn.assigns.current_user.id
		query = from p in Recipe, where: p.user_id == ^userid
    recipes = Repo.all(query)
    render(conn, "shoppinglist.html", recipes: recipes)
	end

	def show_recipe(conn, %{"id" => id}) do
    recipe = Repo.get!(Recipe, id)
		query = from i in Ingredient, where: i.recipe_id == ^id, preload: [:foodcatalog]
    ingredients = Repo.all(query)
    render(conn, "showrecipe.html", recipe: recipe, ingredients: ingredients)
  end

	def recipe_to_grocery(conn, %{"id" => id}) do
    recipe = Repo.get!(Recipe, id)
		query = from i in Ingredient, where: i.recipe_id == ^id, preload: [:foodcatalog]
    ingredients = Repo.all(query)
		for ingredient <- ingredients do
			result = Repo.get_by(Groceryitem, foodcatalog_id: ingredient.foodcatalog_id, user_id: recipe.user_id)
			case result do
				nil ->
					changeset = Groceryitem.changeset(%Groceryitem{}, %{groceryquantity: ingredient.ingredientquantity, foodcatalog_id: ingredient.foodcatalog_id , user_id: recipe.user_id})
					Repo.insert(changeset)
				groceryitem ->
					changeset = Groceryitem.changeset(groceryitem,  %{id: groceryitem.id, groceryquantity: groceryitem.groceryquantity + ingredient.ingredientquantity, foodcatalog_id: ingredient.foodcatalog.id , user_id: recipe.user_id})
					Repo.update(changeset)
			end
		end
    index(conn, %{})
  end
	
end
