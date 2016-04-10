defmodule GroceryGnome.PantryitemController do
  use GroceryGnome.Web, :controller

  alias GroceryGnome.Pantryitem

  plug :scrub_params, "pantryitem" when action in [:create, :update]

  def index(conn, _params) do
    pantryitems = Repo.all(Pantryitem)
    render(conn, "index.html", pantryitems: pantryitems)
  end

  def new(conn, _params) do
    changeset = Pantryitem.changeset(%Pantryitem{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"pantryitem" => pantryitem_params}) do
    changeset = Pantryitem.changeset(%Pantryitem{}, pantryitem_params)

    case Repo.insert(changeset) do
      {:ok, _pantryitem} ->
        conn
        |> put_flash(:info, "Pantryitem created successfully.")
        |> redirect(to: pantryitem_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pantryitem = Repo.get!(Pantryitem, id)
    render(conn, "show.html", pantryitem: pantryitem)
  end

  def edit(conn, %{"id" => id}) do
    pantryitem = Repo.get!(Pantryitem, id)
    changeset = Pantryitem.changeset(pantryitem)
    render(conn, "edit.html", pantryitem: pantryitem, changeset: changeset)
  end

  def update(conn, %{"id" => id, "pantryitem" => pantryitem_params}) do
    pantryitem = Repo.get!(Pantryitem, id)
    changeset = Pantryitem.changeset(pantryitem, pantryitem_params)

    case Repo.update(changeset) do
      {:ok, pantryitem} ->
        conn
        |> put_flash(:info, "Pantryitem updated successfully.")
        |> redirect(to: pantryitem_path(conn, :show, pantryitem))
      {:error, changeset} ->
        render(conn, "edit.html", pantryitem: pantryitem, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pantryitem = Repo.get!(Pantryitem, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(pantryitem)

    conn
    |> put_flash(:info, "Pantryitem deleted successfully.")
    |> redirect(to: pantryitem_path(conn, :index))
  end
end
