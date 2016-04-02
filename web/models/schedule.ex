defmodule GroceryGnome.Schedule do
  use GroceryGnome.Web, :model

  schema "schedules" do
    field :ScheduleID, :integer
    field :Schedule_AccountID, :integer
    field :WeekDate, :string
    field :SundayMealPlanID, :integer
    field :MondayMealPlanID, :integer
    field :TuesdayMealPlanID, :integer
    field :WednesdayMealPlanID, :integer
    field :ThursdayMealPlanID, :integer
    field :FridayMealPlanID, :integer
    field :SaturdayMealPlanID, :integer

    timestamps
  end

  @required_fields ~w(ScheduleID Schedule_AccountID WeekDate SundayMealPlanID MondayMealPlanID TuesdayMealPlanID WednesdayMealPlanID ThursdayMealPlanID FridayMealPlanID SaturdayMealPlanID)
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
