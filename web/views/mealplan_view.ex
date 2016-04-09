defmodule GroceryGnome.MealplanView do
  use GroceryGnome.Web, :view

  def render("index.json", %{mealplans: mealplans}) do
    %{data: render_many(mealplans, GroceryGnome.MealplanView, "mealplan.json")}
  end

  def render("show.json", %{mealplan: mealplan}) do
    %{data: render_one(mealplan, GroceryGnome.MealplanView, "mealplan.json")}
  end

  def render("mealplan.json", %{mealplan: mealplan}) do
    %{id: mealplan.id,
      breakfast: mealplan.breakfast,
      lunch: mealplan.lunch,
      dinner: mealplan.dinner}
  end
end
