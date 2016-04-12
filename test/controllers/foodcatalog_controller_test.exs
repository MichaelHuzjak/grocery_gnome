defmodule GroceryGnome.FoodcatalogControllerTest do
  use GroceryGnome.ConnCase

  alias GroceryGnome.Foodcatalog
  @valid_attrs %{foodname: "some content", info: "some content", unit: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, foodcatalog_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing foodcatalogs"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, foodcatalog_path(conn, :new)
    assert html_response(conn, 200) =~ "New foodcatalog"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, foodcatalog_path(conn, :create), foodcatalog: @valid_attrs
    assert redirected_to(conn) == foodcatalog_path(conn, :index)
    assert Repo.get_by(Foodcatalog, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, foodcatalog_path(conn, :create), foodcatalog: @invalid_attrs
    assert html_response(conn, 200) =~ "New foodcatalog"
  end

  test "shows chosen resource", %{conn: conn} do
    foodcatalog = Repo.insert! %Foodcatalog{}
    conn = get conn, foodcatalog_path(conn, :show, foodcatalog)
    assert html_response(conn, 200) =~ "Show foodcatalog"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, foodcatalog_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    foodcatalog = Repo.insert! %Foodcatalog{}
    conn = get conn, foodcatalog_path(conn, :edit, foodcatalog)
    assert html_response(conn, 200) =~ "Edit foodcatalog"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    foodcatalog = Repo.insert! %Foodcatalog{}
    conn = put conn, foodcatalog_path(conn, :update, foodcatalog), foodcatalog: @valid_attrs
    assert redirected_to(conn) == foodcatalog_path(conn, :show, foodcatalog)
    assert Repo.get_by(Foodcatalog, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    foodcatalog = Repo.insert! %Foodcatalog{}
    conn = put conn, foodcatalog_path(conn, :update, foodcatalog), foodcatalog: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit foodcatalog"
  end

  test "deletes chosen resource", %{conn: conn} do
    foodcatalog = Repo.insert! %Foodcatalog{}
    conn = delete conn, foodcatalog_path(conn, :delete, foodcatalog)
    assert redirected_to(conn) == foodcatalog_path(conn, :index)
    refute Repo.get(Foodcatalog, foodcatalog.id)
  end
end
