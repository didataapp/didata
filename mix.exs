defmodule Didata.MixProject do
  use Mix.Project

  def project do
    [
      app: :didata,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Didata.Application, []},
      extra_applications: [:ex_machina, :logger, :runtime_tools]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:distillery, "~> 2.1"},
      {:ecto_sql, "~> 3.1"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:phoenix, "~> 1.5.0-rc.0", override: true},
      {:phoenix_ecto, "~> 4.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_dashboard, "~> 0.1"},
      {:phoenix_pubsub, "~> 2.0"},
      {:plug_cowboy, "~> 2.1"},
      {:postgrex, ">= 0.0.0"},
      {:telemetry_poller, "~> 0.4"},
      {:telemetry_metrics, "~> 0.4"},
      # dev/test
      {:credo, "~> 1.3", only: [:dev, :test], runtime: false},
      {:ex_machina, "~> 2.4"},
      {:phoenix_live_reload, "~> 1.2", only: :dev}
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
