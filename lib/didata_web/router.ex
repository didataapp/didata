defmodule DidataWeb.Router do
  use DidataWeb, :router

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
  end
end
