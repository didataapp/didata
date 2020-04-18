defmodule Didata.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Phoenix.PubSub, name: Didata.PubSub},
      Didata.Repo,
      DidataWeb.Telemetry,
      DidataWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Didata.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    DidataWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
