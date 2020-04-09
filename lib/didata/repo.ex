defmodule Didata.Repo do
  use Ecto.Repo,
    otp_app: :didata,
    adapter: Ecto.Adapters.Postgres
end
