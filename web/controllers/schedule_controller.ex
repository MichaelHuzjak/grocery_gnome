defmodule GroceryGnome.ScheduleController do
	use GroceryGnome.Web, :controller

	plug GroceryGnome.Plug.Authenticate
	alias GroceryGnome.Day
	alias GroceryGnome.Recipe
	alias GroceryGnome.Foodcatalog
	alias GroceryGnome.Ingredient

	def index(conn, _params) do
		days = Repo.all(Day)
		for d <- days do
			IO.inspect d
		end
		render(conn, "index.html", days: days)
	end

	def generate(conn, _params) do
		date = conn.params["form_data"]["date"]
		userid = conn.assigns.current_user.id
		{:ok, meals} = GroceryGnome.Spoonacular.caloried_meal_plan 2000, "day"
		[breakfast, lunch, dinner] = meals["meals"]
		IO.inspect date
		d = ~s/#{date["year"]}-#{date["month"]}-#{date["day"]}/
		changeset = Day.changeset(%Day{}, %{
					breakfast: [breakfast["id"], 1433],
					lunch: [lunch["id"], 1234, 51515],
					dinner: [dinner["id"]],
					date: d,
					user_id: userid})
		# render(conn, "index.html", changeset: changeset)
		case Repo.insert(changeset) do
			{:ok, _day} ->
				conn
				|> put_flash(:info, "Generated plan")
				|> redirect(to: schedule_path(conn, :index))
			{:error, changeset} ->
				IO.inspect changeset
				conn
				|> put_flash(:error, "Error occured")
				|> redirect(to: schedule_path(conn, :index))
		end
	end

	def generatetodatabase(conn, _params) do
		date = conn.params["form_data"]["date"]
		userid = conn.assigns.current_user.id
		{:ok, meals} = GroceryGnome.Spoonacular.caloried_meal_plan 2000, "day"
		[breakfast, lunch, dinner] = meals["meals"]
		IO.inspect date
		date = ~s/#{date["year"]}-#{date["month"]}-#{date["day"]}/
		#breakfast
		{:ok, b} = GroceryGnome.Spoonacular.recipe_information breakfast["id"], false
		IO.inspect b
		recipe_add(userid,b)
		b = Repo.get_by(Recipe, recipe_title: b["title"])
		#lunch
		{:ok, l} = GroceryGnome.Spoonacular.recipe_information lunch["id"], false
		IO.inspect l
		recipe_add(userid,l)
		l = Repo.get_by(Recipe, recipe_title: l["title"])
		#dinner
		{:ok, d} = GroceryGnome.Spoonacular.recipe_information dinner["id"], false
		IO.inspect d
		recipe_add(userid,d)
		d = Repo.get_by(Recipe, recipe_title: d["title"])

		changeset = Day.changeset(%Day{}, %{
					breakfast: [b.id],
					lunch: [l.id],
					dinner: [d.id],
					date: date,
					user_id: userid})
		
		case Repo.insert(changeset) do
			{:ok, _day} ->
				conn
				|> put_flash(:info, "Generated plan #{b.id}")
				|> redirect(to: schedule_path(conn, :index))
			{:error, changeset} ->
				IO.inspect changeset
				conn
				|> put_flash(:error, "Error occured")
				|> redirect(to: schedule_path(conn, :index))
		end
	end


	def recipe_add(userid, recipe) do
	#	{:ok, recipe} = GroceryGnome.Spoonacular.recipe_information id, false
	#	IO.inspect recipe

		# create the recipe
    changeset = Recipe.changeset(%Recipe{}, %{recipe_title: recipe["title"], instructions: "Filler", prep_time: recipe["readyInMinutes"], cook_time: recipe["readyInMinutes"], user_id: userid})

    case Repo.insert(changeset) do
      {:ok, _recipe} ->
				# Since change was inserted into the database ok
				recipe_id = _recipe.id
				# Removing keywords from parameter map
				for ingredient <- recipe["extendedIngredients"] do
					result = Repo.get_by(Foodcatalog, foodname: ingredient["name"])
					case result do
						nil ->
							foodcatalogchangeset = Foodcatalog.changeset(%Foodcatalog{}, %{foodname: ingredient["name"], unit: ingredient["unit"], info: ingredient["aisle"]})
							case Repo.insert(foodcatalogchangeset) do
								      {:ok, _foodcatalog} ->
									ingredient_changeset = Ingredient.changeset(%Ingredient{}, %{ foodcatalog_id: _foodcatalog.id, ingredientquantity: ingredient["amount"], recipe_id: recipe_id})
									Repo.insert(ingredient_changeset)
								end
						foodcatalog ->
									ingredient_changeset = Ingredient.changeset(%Ingredient{}, %{ foodcatalog_id: foodcatalog.id, ingredientquantity: ingredient["amount"], recipe_id: recipe_id})
									Repo.insert(ingredient_changeset)
					end
				end
		end
	end
	

	def delete(conn, %{"id" => id}) do
		day = Repo.get!(Day, id)

		Repo.delete!(day)

		conn
		|> put_flash(:info, "Deleted day")
		|> redirect(to: schedule_path(conn, :index))
	end

	def new(conn, _params) do
		IO.inspect conn
		changeset = Day.changeset(%Day{})
		render(conn, "new.html", changeset: changeset)
	end

end
