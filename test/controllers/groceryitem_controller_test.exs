defmodule GroceryGnome.GroceryitemControllerTest do
  use GroceryGnome.ConnCase

  alias GroceryGnome.Groceryitem
  @valid_attrs %{groceryquantity: "120.5"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, groceryitem_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing groceryitems"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, groceryitem_path(conn, :new)
    assert html_response(conn, 200) =~ "New groceryitem"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, groceryitem_path(conn, :create), groceryitem: @valid_attrs
    assert redirected_to(conn) == groceryitem_path(conn, :index)
    assert Repo.get_by(Groceryitem, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, groceryitem_path(conn, :create), groceryitem: @invalid_attrs
    assert html_response(conn, 200) =~ "New groceryitem"
  end

  test "shows chosen resource", %{conn: conn} do
    groceryitem = Repo.insert! %Groceryitem{}
    conn = get conn, groceryitem_path(conn, :show, groceryitem)
    assert html_response(conn, 200) =~ "Show groceryitem"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, groceryitem_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    groceryitem = Repo.insert! %Groceryitem{}
    conn = get conn, groceryitem_path(conn, :edit, groceryitem)
    assert html_response(conn, 200) =~ "Edit groceryitem"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    groceryitem = Repo.insert! %Groceryitem{}
    conn = put conn, groceryitem_path(conn, :update, groceryitem), groceryitem: @valid_attrs
    assert redirected_to(conn) == groceryitem_path(conn, :show, groceryitem)
    assert Repo.get_by(Groceryitem, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    groceryitem = Repo.insert! %Groceryitem{}
    conn = put conn, groceryitem_path(conn, :update, groceryitem), groceryitem: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit groceryitem"
  end

  test "deletes chosen resource", %{conn: conn} do
    groceryitem = Repo.insert! %Groceryitem{}
    conn = delete conn, groceryitem_path(conn, :delete, groceryitem)
    assert redirected_to(conn) == groceryitem_path(conn, :index)
    refute Repo.get(Groceryitem, groceryitem.id)
  end
end
