defmodule GroceryGnome.RecipeControllerTest do
  use GroceryGnome.ConnCase

  alias GroceryGnome.Recipe
  @valid_attrs %{cook_time: 42, ingredients: %{}, instructions: "some content", prep_time: 42}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, recipe_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing recipes"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, recipe_path(conn, :new)
    assert html_response(conn, 200) =~ "New recipe"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, recipe_path(conn, :create), recipe: @valid_attrs
    assert redirected_to(conn) == recipe_path(conn, :index)
    assert Repo.get_by(Recipe, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, recipe_path(conn, :create), recipe: @invalid_attrs
    assert html_response(conn, 200) =~ "New recipe"
  end

  test "shows chosen resource", %{conn: conn} do
    recipe = Repo.insert! %Recipe{}
    conn = get conn, recipe_path(conn, :show, recipe)
    assert html_response(conn, 200) =~ "Show recipe"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, recipe_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    recipe = Repo.insert! %Recipe{}
    conn = get conn, recipe_path(conn, :edit, recipe)
    assert html_response(conn, 200) =~ "Edit recipe"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    recipe = Repo.insert! %Recipe{}
    conn = put conn, recipe_path(conn, :update, recipe), recipe: @valid_attrs
    assert redirected_to(conn) == recipe_path(conn, :show, recipe)
    assert Repo.get_by(Recipe, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    recipe = Repo.insert! %Recipe{}
    conn = put conn, recipe_path(conn, :update, recipe), recipe: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit recipe"
  end

  test "deletes chosen resource", %{conn: conn} do
    recipe = Repo.insert! %Recipe{}
    conn = delete conn, recipe_path(conn, :delete, recipe)
    assert redirected_to(conn) == recipe_path(conn, :index)
    refute Repo.get(Recipe, recipe.id)
  end
end
