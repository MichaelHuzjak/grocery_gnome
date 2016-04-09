defmodule GroceryGnome.MealplanControllerTest do
  use GroceryGnome.ConnCase

  alias GroceryGnome.Mealplan
  @valid_attrs %{breakfast: "some content", dinner: "some content", lunch: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, mealplan_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    mealplan = Repo.insert! %Mealplan{}
    conn = get conn, mealplan_path(conn, :show, mealplan)
    assert json_response(conn, 200)["data"] == %{"id" => mealplan.id,
      "breakfast" => mealplan.breakfast,
      "lunch" => mealplan.lunch,
      "dinner" => mealplan.dinner}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, mealplan_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, mealplan_path(conn, :create), mealplan: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Mealplan, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, mealplan_path(conn, :create), mealplan: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    mealplan = Repo.insert! %Mealplan{}
    conn = put conn, mealplan_path(conn, :update, mealplan), mealplan: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Mealplan, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    mealplan = Repo.insert! %Mealplan{}
    conn = put conn, mealplan_path(conn, :update, mealplan), mealplan: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    mealplan = Repo.insert! %Mealplan{}
    conn = delete conn, mealplan_path(conn, :delete, mealplan)
    assert response(conn, 204)
    refute Repo.get(Mealplan, mealplan.id)
  end
end
