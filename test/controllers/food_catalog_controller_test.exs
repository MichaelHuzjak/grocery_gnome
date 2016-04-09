defmodule GroceryGnome.FoodCatalogControllerTest do
  use GroceryGnome.ConnCase

  alias GroceryGnome.FoodCatalog
  @valid_attrs %{info: "some content", name: "some content", units: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, food_catalog_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing food catalog"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, food_catalog_path(conn, :new)
    assert html_response(conn, 200) =~ "New food catalog"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, food_catalog_path(conn, :create), food_catalog: @valid_attrs
    assert redirected_to(conn) == food_catalog_path(conn, :index)
    assert Repo.get_by(FoodCatalog, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, food_catalog_path(conn, :create), food_catalog: @invalid_attrs
    assert html_response(conn, 200) =~ "New food catalog"
  end

  test "shows chosen resource", %{conn: conn} do
    food_catalog = Repo.insert! %FoodCatalog{}
    conn = get conn, food_catalog_path(conn, :show, food_catalog)
    assert html_response(conn, 200) =~ "Show food catalog"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, food_catalog_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    food_catalog = Repo.insert! %FoodCatalog{}
    conn = get conn, food_catalog_path(conn, :edit, food_catalog)
    assert html_response(conn, 200) =~ "Edit food catalog"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    food_catalog = Repo.insert! %FoodCatalog{}
    conn = put conn, food_catalog_path(conn, :update, food_catalog), food_catalog: @valid_attrs
    assert redirected_to(conn) == food_catalog_path(conn, :show, food_catalog)
    assert Repo.get_by(FoodCatalog, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    food_catalog = Repo.insert! %FoodCatalog{}
    conn = put conn, food_catalog_path(conn, :update, food_catalog), food_catalog: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit food catalog"
  end

  test "deletes chosen resource", %{conn: conn} do
    food_catalog = Repo.insert! %FoodCatalog{}
    conn = delete conn, food_catalog_path(conn, :delete, food_catalog)
    assert redirected_to(conn) == food_catalog_path(conn, :index)
    refute Repo.get(FoodCatalog, food_catalog.id)
  end
end
