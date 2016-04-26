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
		userid = conn.assigns.current_user.id
		{:ok, meals} = GroceryGnome.Spoonacular.caloried_meal_plan 2000, "day"
		[breakfast, lunch, dinner] = meals["meals"]
		changeset = %Day{
			breakfast: [breakfast["id"], 1433],
			lunch: [lunch["id"], 1234, 51515],
			dinner: [dinner["id"]],
			date: to_string(Ecto.Date.utc),
			user_id: userid,
		}
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

end
