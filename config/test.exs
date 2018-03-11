use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :koala, KoalaWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :koala, Koala.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  # username: System.get_env("DATABASE_USERNAME"),
  # password: System.get_env("DATABASE_PASSWORD"),
  database: "koala_test",
  hostname: System.get_env("DATABASE_HOST"),
  pool: Ecto.Adapters.SQL.Sandbox
