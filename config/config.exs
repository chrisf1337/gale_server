# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :gale_server,
  ecto_repos: [GaleServer.Repo]

# Configures the endpoint
config :gale_server, GaleServer.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6YSHQR9Oz0OlIXa0IDrv8G/ykxCweLwUHywXzgkicDRmmUyneIPUCJlbO8iDRTbo",
  render_errors: [view: GaleServer.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GaleServer.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  issuer: "GaleServer",
  ttl: {30, :days},
  serializer: GaleServer.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
