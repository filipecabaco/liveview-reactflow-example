import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :react_node_demo, ReactNodeDemoWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "lCNM9iGttTbbO8DRkBvNNjWKEU55pBN8Bd6rfViJ85OgDpPCoIXgfh8gl2P03UbV",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
