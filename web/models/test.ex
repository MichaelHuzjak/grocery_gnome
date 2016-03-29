defmodule User do
	use Ecto.Schema

	# def changeset(user, params \\ :empty) do
	# 	cast(user, params, ~w(name age), ~w())
	# end

	schema "users" do
		field :name
		embeds_one :permalink, Permalink
	end
end

defmodule Permalink do
	use Ecto.Schema
	embedded_schema do
		field :url
	end
end
