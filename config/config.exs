# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :didata,
  ecto_repos: [Didata.Repo]

# Configures the endpoint
config :didata, DidataWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "q1OOqjkgYGGvJG+r3YhNeALpcBMHUoAh0icQ/BmI6A7JJDUpuVyDxWvkarbQ0tse",
  render_errors: [view: DidataWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: Didata.PubSub,
  live_view: [signing_salt: "peZDyUFf"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :didata, Didata.Mailer,
  adapter: Bamboo.SendGridAdapter,
  api_key: {:system, "SENDGRID_API_KEY"},
  hackney_opts: [
    recv_timeout: :timer.minutes(1)
  ]

config :didata, sender_email: {:system, "DIDATA_SENDER_EMAIL"}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
