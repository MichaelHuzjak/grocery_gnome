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
#   allowed_algos: ["HS512"], # hs512 is the default, probably works well enough
#   verify_module: Guardian,JWT, # mechanism to setup validations for items in the token
#   issuer: "GroceryGnome" # put into token as issuer
#   ttl: {30, :days}, # time to live
# 	verify_issuer: true,
# 	secret_key: # some secret key to sign the tokens
# 	serializer: GroceryGnome.GuardianSerializer # serializes thesubject field into and out of the token
