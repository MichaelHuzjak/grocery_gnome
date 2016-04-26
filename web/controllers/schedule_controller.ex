defmodule GroceryGnome.ScheduleController do
	use GroceryGnome.Web, :controller

	plug GroceryGnome.Plug.Authenticate
	alias GroceryGnome.Day

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
