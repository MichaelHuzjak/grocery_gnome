defmodule GroceryGnome.DayControllerTest do
  use GroceryGnome.ConnCase

  alias GroceryGnome.Day
  @valid_attrs %{breakfast: [], date: "some content", dinner: [], lunch: []}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, day_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing days"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, day_path(conn, :new)
    assert html_response(conn, 200) =~ "New day"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, day_path(conn, :create), day: @valid_attrs
    assert redirected_to(conn) == day_path(conn, :index)
    assert Repo.get_by(Day, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, day_path(conn, :create), day: @invalid_attrs
    assert html_response(conn, 200) =~ "New day"
  end

  test "shows chosen resource", %{conn: conn} do
    day = Repo.insert! %Day{}
    conn = get conn, day_path(conn, :show, day)
    assert html_response(conn, 200) =~ "Show day"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, day_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    day = Repo.insert! %Day{}
    conn = get conn, day_path(conn, :edit, day)
    assert html_response(conn, 200) =~ "Edit day"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    day = Repo.insert! %Day{}
    conn = put conn, day_path(conn, :update, day), day: @valid_attrs
    assert redirected_to(conn) == day_path(conn, :show, day)
    assert Repo.get_by(Day, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    day = Repo.insert! %Day{}
    conn = put conn, day_path(conn, :update, day), day: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit day"
  end

  test "deletes chosen resource", %{conn: conn} do
    day = Repo.insert! %Day{}
    conn = delete conn, day_path(conn, :delete, day)
    assert redirected_to(conn) == day_path(conn, :index)
    refute Repo.get(Day, day.id)
  end
end
