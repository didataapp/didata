use Mix.Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

# Configure your database for local testing
config :didata, Didata.Repo,
  username: "postgres",
  password: "postgres",
  database: "didata_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Configure the database for GitHub Actions
if System.get_env("GITHUB_ACTIONS") do
  config :didata, Didata.Repo,
    username: "postgres",
    password: "postgres"
end

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :didata, DidataWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :didata, Didata.Mailer, adapter: Bamboo.TestAdapter

config :didata, sender_email: "sender@example.com"
