defmodule GroceryGnome.MealplanController do
  use GroceryGnome.Web, :controller

  alias GroceryGnome.Mealplan

  plug :scrub_params, "mealplan" when action in [:create, :update]

  def index(conn, _params) do
    mealplans = Repo.all(Mealplan)
    render(conn, "index.json", mealplans: mealplans)
  end

  def create(conn, %{"mealplan" => mealplan_params}) do
    changeset = Mealplan.changeset(%Mealplan{}, mealplan_params)

    case Repo.insert(changeset) do
      {:ok, mealplan} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", mealplan_path(conn, :show, mealplan))
        |> render("show.json", mealplan: mealplan)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(GroceryGnome.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    mealplan = Repo.get!(Mealplan, id)
    render(conn, "show.json", mealplan: mealplan)
  end

  def update(conn, %{"id" => id, "mealplan" => mealplan_params}) do
    mealplan = Repo.get!(Mealplan, id)
    changeset = Mealplan.changeset(mealplan, mealplan_params)

    case Repo.update(changeset) do
      {:ok, mealplan} ->
        render(conn, "show.json", mealplan: mealplan)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(GroceryGnome.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    mealplan = Repo.get!(Mealplan, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(mealplan)

    send_resp(conn, :no_content, "")
  end
end
