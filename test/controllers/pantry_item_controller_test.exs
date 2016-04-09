defmodule GroceryGnome.PantryItemControllerTest do
  use GroceryGnome.ConnCase

  alias GroceryGnome.PantryItem
  @valid_attrs %{expiration: %{}, quantity: "120.5"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, pantry_item_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing pantry items"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, pantry_item_path(conn, :new)
    assert html_response(conn, 200) =~ "New pantry item"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, pantry_item_path(conn, :create), pantry_item: @valid_attrs
    assert redirected_to(conn) == pantry_item_path(conn, :index)
    assert Repo.get_by(PantryItem, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, pantry_item_path(conn, :create), pantry_item: @invalid_attrs
    assert html_response(conn, 200) =~ "New pantry item"
  end

  test "shows chosen resource", %{conn: conn} do
    pantry_item = Repo.insert! %PantryItem{}
    conn = get conn, pantry_item_path(conn, :show, pantry_item)
    assert html_response(conn, 200) =~ "Show pantry item"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, pantry_item_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    pantry_item = Repo.insert! %PantryItem{}
    conn = get conn, pantry_item_path(conn, :edit, pantry_item)
    assert html_response(conn, 200) =~ "Edit pantry item"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    pantry_item = Repo.insert! %PantryItem{}
    conn = put conn, pantry_item_path(conn, :update, pantry_item), pantry_item: @valid_attrs
    assert redirected_to(conn) == pantry_item_path(conn, :show, pantry_item)
    assert Repo.get_by(PantryItem, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    pantry_item = Repo.insert! %PantryItem{}
    conn = put conn, pantry_item_path(conn, :update, pantry_item), pantry_item: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit pantry item"
  end

  test "deletes chosen resource", %{conn: conn} do
    pantry_item = Repo.insert! %PantryItem{}
    conn = delete conn, pantry_item_path(conn, :delete, pantry_item)
    assert redirected_to(conn) == pantry_item_path(conn, :index)
    refute Repo.get(PantryItem, pantry_item.id)
  end
end
