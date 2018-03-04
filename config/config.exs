# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :koala,
  ecto_repos: [Koala.Repo]

# Configures the endpoint
config :koala, KoalaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ebFZwIuOJhvI8xZvnYW1h9asoUIBqe6sf0baE/p5lWyIAjyawb1vxUVdYyGsWmNA",
  render_errors: [view: KoalaWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Koala.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
