defmodule GroceryGnome.PantryitemControllerTest do
  use GroceryGnome.ConnCase

  alias GroceryGnome.Pantryitem
  @valid_attrs %{expiration: "some content", pantryquantity: "120.5"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, pantryitem_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing pantryitems"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, pantryitem_path(conn, :new)
    assert html_response(conn, 200) =~ "New pantryitem"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, pantryitem_path(conn, :create), pantryitem: @valid_attrs
    assert redirected_to(conn) == pantryitem_path(conn, :index)
    assert Repo.get_by(Pantryitem, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, pantryitem_path(conn, :create), pantryitem: @invalid_attrs
    assert html_response(conn, 200) =~ "New pantryitem"
  end

  test "shows chosen resource", %{conn: conn} do
    pantryitem = Repo.insert! %Pantryitem{}
    conn = get conn, pantryitem_path(conn, :show, pantryitem)
    assert html_response(conn, 200) =~ "Show pantryitem"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, pantryitem_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    pantryitem = Repo.insert! %Pantryitem{}
    conn = get conn, pantryitem_path(conn, :edit, pantryitem)
    assert html_response(conn, 200) =~ "Edit pantryitem"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    pantryitem = Repo.insert! %Pantryitem{}
    conn = put conn, pantryitem_path(conn, :update, pantryitem), pantryitem: @valid_attrs
    assert redirected_to(conn) == pantryitem_path(conn, :show, pantryitem)
    assert Repo.get_by(Pantryitem, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    pantryitem = Repo.insert! %Pantryitem{}
    conn = put conn, pantryitem_path(conn, :update, pantryitem), pantryitem: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit pantryitem"
  end

  test "deletes chosen resource", %{conn: conn} do
    pantryitem = Repo.insert! %Pantryitem{}
    conn = delete conn, pantryitem_path(conn, :delete, pantryitem)
    assert redirected_to(conn) == pantryitem_path(conn, :index)
    refute Repo.get(Pantryitem, pantryitem.id)
  end
end
