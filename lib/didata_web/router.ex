defmodule DidataWeb.Router do
  use DidataWeb, :router
  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", DidataWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/objectives", ObjectiveController
    resources "/areas", AreaController
    resources "/disciplines", DisciplineController
    resources "/topics", TopicController
    resources "/subtopics", SubtopicController
    resources "/contents", ContentController
  end

  if Mix.env() == :dev do
    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: DidataWeb.Telemetry
    end
  end
end
