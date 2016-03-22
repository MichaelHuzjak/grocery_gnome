defmodule GroceryGnome.Sample do
	use Ecto.Schema

	schema "weather" do
		field :city 								# default type is string
		field :temp_lo, :integer
		field :temp_hi, :integer
		field :prcp,    :float, default: 0.0
	end
end
