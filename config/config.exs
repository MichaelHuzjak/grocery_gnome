# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :grocery_gnome, GroceryGnome.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "gc5H3b/8KryU3tA+bY5cigu2Br5Ww5F8lIgFyUudGLU4Ik2imog0VKXwjC7GmdAf",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: GroceryGnome.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :grocery_gnome, GroceryGnome.Repo,
  adapter: Ecto.Adapters.Postgres,
	database: "ecto_simple",
	username: "postgres",
	password: "postgres",
	hostname: "localhost"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

# config :guardian, Guardian,
#   allowed_algos: ["HS512"], # optional
#   verify_module: Guardian.JWT,  # optional
#   issuer: "GroceryGnome",
#   ttl: { 30, :days },
#   verify_issuer: true, # optional
#   secret_key: <guardian secret key>,
#   serializer: MyApp.GuardianSerializer
