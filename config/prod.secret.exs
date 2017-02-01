use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :telematicap1, Telematicap1.Endpoint,
  secret_key_base: "Q4c4Dqznd2p59spkCK4hofOr05/YYCa1N51TZ0NYTvghzPshKV0XHi7/rbvLjl0Q"

# Configure your database
config :telematicap1, Telematicap1.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "telematicap1_prod",
  pool_size: 20
