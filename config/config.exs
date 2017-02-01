# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :telematicap1,
  ecto_repos: [Telematicap1.Repo]

# Configures the endpoint
config :telematicap1, Telematicap1.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Qs4sbx0TlMZp9F47FRO8H7caKDMlt44RGsNqFaI0zaskVYX91qxR4NaP8d+A7+Po",
  render_errors: [view: Telematicap1.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Telematicap1.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

  config :passport,
    resource: Telematicap1.User,
    repo: Telematicap1.Repo

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
