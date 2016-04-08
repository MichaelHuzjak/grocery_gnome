defmodule GroceryGnome.GroceryitemController do
  use GroceryGnome.Web, :controller

  alias GroceryGnome.Groceryitem

  plug :scrub_params, "groceryitem" when action in [:create, :update]

  def index(conn, _params) do
    groceryitems = Repo.all(Groceryitem)
    render(conn, "index.html", groceryitems: groceryitems)
  end

  def new(conn, _params) do
    changeset = Groceryitem.changeset(%Groceryitem{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"groceryitem" => groceryitem_params}) do
    changeset = Groceryitem.changeset(%Groceryitem{}, groceryitem_params)

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
end
