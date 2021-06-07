# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :contact_trace_server,
  ecto_repos: [ContactTraceServer.Repo]

# Configures the endpoint
config :contact_trace_server, ContactTraceServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CTfo7nbkeLJghbIoeGRdbw10j+f06NQ33SdjaeRMgIKOMtPuIa+f4GGxfKGsKskO",
  render_errors: [view: ContactTraceServerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ContactTraceServer.PubSub,
  live_view: [signing_salt: "akSljhC9"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
