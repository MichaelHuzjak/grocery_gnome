defmodule GroceryGnome.RecipebookControllerTest do
  use GroceryGnome.ConnCase

  alias GroceryGnome.Recipebook
  @valid_attrs %{body: "some content", word_count: 42}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, recipebook_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing recipebooks"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, recipebook_path(conn, :new)
    assert html_response(conn, 200) =~ "New recipebook"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, recipebook_path(conn, :create), recipebook: @valid_attrs
    assert redirected_to(conn) == recipebook_path(conn, :index)
    assert Repo.get_by(Recipebook, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, recipebook_path(conn, :create), recipebook: @invalid_attrs
    assert html_response(conn, 200) =~ "New recipebook"
  end

  test "shows chosen resource", %{conn: conn} do
    recipebook = Repo.insert! %Recipebook{}
    conn = get conn, recipebook_path(conn, :show, recipebook)
    assert html_response(conn, 200) =~ "Show recipebook"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, recipebook_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    recipebook = Repo.insert! %Recipebook{}
    conn = get conn, recipebook_path(conn, :edit, recipebook)
    assert html_response(conn, 200) =~ "Edit recipebook"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    recipebook = Repo.insert! %Recipebook{}
    conn = put conn, recipebook_path(conn, :update, recipebook), recipebook: @valid_attrs
    assert redirected_to(conn) == recipebook_path(conn, :show, recipebook)
    assert Repo.get_by(Recipebook, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    recipebook = Repo.insert! %Recipebook{}
    conn = put conn, recipebook_path(conn, :update, recipebook), recipebook: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit recipebook"
  end

  test "deletes chosen resource", %{conn: conn} do
    recipebook = Repo.insert! %Recipebook{}
    conn = delete conn, recipebook_path(conn, :delete, recipebook)
    assert redirected_to(conn) == recipebook_path(conn, :index)
    refute Repo.get(Recipebook, recipebook.id)
  end
end
