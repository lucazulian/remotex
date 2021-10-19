import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :remotex, Remotex.Repo,
  username: "remotex",
  password: "remotex",
  database: "remotex_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "remotex-db",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :remotex, RemotexWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "UGqIivS5We60wIyqJc4iA6bTDIrBygiPcZq5uMp8UkRQDlGnE40YhSNGDnPnUWci",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
