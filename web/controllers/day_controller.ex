defmodule GroceryGnome.DayController do
  use GroceryGnome.Web, :controller

  alias GroceryGnome.Day

  plug :scrub_params, "day" when action in [:create, :update]

  def index(conn, _params) do
    days = Repo.all(Day)
    render(conn, "index.html", days: days)
  end

  def new(conn, _params) do
    changeset = Day.changeset(%Day{})
    render(conn, "new.html", changeset: changeset)
v  end

  def create(conn, %{"day" => day_params}) do
    changeset = Day.changeset(%Day{}, day_params)

    case Repo.insert(changeset) do
      {:ok, _day} ->
        conn
        |> put_flash(:info, "Day created successfully.")
        |> redirect(to: day_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    day = Repo.get!(Day, id)
    render(conn, "show.html", day: day)
  end

  def edit(conn, %{"id" => id}) do
    day = Repo.get!(Day, id)
    changeset = Day.changeset(day)
    render(conn, "edit.html", day: day, changeset: changeset)
  end

  def update(conn, %{"id" => id, "day" => day_params}) do
    day = Repo.get!(Day, id)
    changeset = Day.changeset(day, day_params)

    case Repo.update(changeset) do
      {:ok, day} ->
        conn
        |> put_flash(:info, "Day updated successfully.")
        |> redirect(to: day_path(conn, :show, day))
      {:error, changeset} ->
        render(conn, "edit.html", day: day, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    day = Repo.get!(Day, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(day)

    conn
    |> put_flash(:info, "Day deleted successfully.")
    |> redirect(to: day_path(conn, :index))
  end
end
