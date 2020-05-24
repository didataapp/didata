# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
use Mix.Config

config :didata, Didata.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "",
  ssl: true,
  url: System.fetch_env!("DATABASE_URL"),
  pool_size: 2

config :didata, DidataWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: System.fetch_env!("SECRET_KEY_BASE")

# Mailer
config :didata, Didata.Mailer,
  adapter: Bamboo.SendGridAdapter,
  api_key: System.fetch_env!("SENDGRID_API_KEY"),
  hackney_opts: [
    recv_timeout: :timer.minutes(1)
  ]

config :didata, sender_email: System.fetch_env!("DIDATA_SENDER_EMAIL")

# Admin
config :didata, admin_email: System.fetch_env!("DIDATA_ADMIN_EMAIL")
