defmodule GroceryGnome.FooditemControllerTest do
  use GroceryGnome.ConnCase

  alias GroceryGnome.Fooditem
  @valid_attrs %{foodname: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, fooditem_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing fooditems"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, fooditem_path(conn, :new)
    assert html_response(conn, 200) =~ "New fooditem"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, fooditem_path(conn, :create), fooditem: @valid_attrs
    assert redirected_to(conn) == fooditem_path(conn, :index)
    assert Repo.get_by(Fooditem, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, fooditem_path(conn, :create), fooditem: @invalid_attrs
    assert html_response(conn, 200) =~ "New fooditem"
  end

  test "shows chosen resource", %{conn: conn} do
    fooditem = Repo.insert! %Fooditem{}
    conn = get conn, fooditem_path(conn, :show, fooditem)
    assert html_response(conn, 200) =~ "Show fooditem"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, fooditem_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    fooditem = Repo.insert! %Fooditem{}
    conn = get conn, fooditem_path(conn, :edit, fooditem)
    assert html_response(conn, 200) =~ "Edit fooditem"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    fooditem = Repo.insert! %Fooditem{}
    conn = put conn, fooditem_path(conn, :update, fooditem), fooditem: @valid_attrs
    assert redirected_to(conn) == fooditem_path(conn, :show, fooditem)
    assert Repo.get_by(Fooditem, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    fooditem = Repo.insert! %Fooditem{}
    conn = put conn, fooditem_path(conn, :update, fooditem), fooditem: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit fooditem"
  end

  test "deletes chosen resource", %{conn: conn} do
    fooditem = Repo.insert! %Fooditem{}
    conn = delete conn, fooditem_path(conn, :delete, fooditem)
    assert redirected_to(conn) == fooditem_path(conn, :index)
    refute Repo.get(Fooditem, fooditem.id)
  end
end
