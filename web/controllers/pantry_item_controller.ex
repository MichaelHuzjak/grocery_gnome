defmodule GroceryGnome.PantryItemController do
  use GroceryGnome.Web, :controller

  alias GroceryGnome.PantryItem

  plug :scrub_params, "pantry_item" when action in [:create, :update]

  def index(conn, _params) do
    pantry_items = Repo.all(PantryItem)
    render(conn, "index.html", pantry_items: pantry_items)
  end

  def new(conn, _params) do
    changeset = PantryItem.changeset(%PantryItem{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"pantry_item" => pantry_item_params}) do
    changeset = PantryItem.changeset(%PantryItem{}, pantry_item_params)

    case Repo.insert(changeset) do
      {:ok, _pantry_item} ->
        conn
        |> put_flash(:info, "Pantry item created successfully.")
        |> redirect(to: pantry_item_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pantry_item = Repo.get!(PantryItem, id)
    render(conn, "show.html", pantry_item: pantry_item)
  end

  def edit(conn, %{"id" => id}) do
    pantry_item = Repo.get!(PantryItem, id)
    changeset = PantryItem.changeset(pantry_item)
    render(conn, "edit.html", pantry_item: pantry_item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "pantry_item" => pantry_item_params}) do
    pantry_item = Repo.get!(PantryItem, id)
    changeset = PantryItem.changeset(pantry_item, pantry_item_params)

    case Repo.update(changeset) do
      {:ok, pantry_item} ->
        conn
        |> put_flash(:info, "Pantry item updated successfully.")
        |> redirect(to: pantry_item_path(conn, :show, pantry_item))
      {:error, changeset} ->
        render(conn, "edit.html", pantry_item: pantry_item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pantry_item = Repo.get!(PantryItem, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(pantry_item)

    conn
    |> put_flash(:info, "Pantry item deleted successfully.")
    |> redirect(to: pantry_item_path(conn, :index))
  end
end
