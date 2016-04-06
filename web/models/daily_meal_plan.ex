defmodule GroceryGnome.DailyMealPlan do
  use GroceryGnome.Web, :model

  schema "dailymealplans" do
    field :BreakfastID, :integer
    field :LunchID, :integer
    field :DinnerID, :integer

    timestamps
  end

  @required_fields ~w(DailyMealPlanID BreakfastID LunchID DinnerID)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
