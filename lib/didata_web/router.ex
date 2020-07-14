defmodule DidataWeb.Router do
  use DidataWeb, :router

  import DidataWeb.UserAuth
  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  scope "/", DidataWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/objectives/:objective_id", PageController, :objective
    get "/areas/:area_id", PageController, :area
    get "/disciplines/:discipline_id", PageController, :discipline
    get "/topics/:topic_id", PageController, :topic
  end

  # Admin routes
  pipeline :admins_only do
    plug :require_authenticated_user
    plug :require_admin_user
  end

  scope "/admin", DidataWeb.Admin, as: :admin do
    pipe_through [:browser, :admins_only]

    live_dashboard "/dashboard", metrics: DidataWeb.Telemetry

    resources "/objectives", ObjectiveController
    resources "/areas", AreaController
    resources "/disciplines", DisciplineController
    resources "/topics", TopicController
    resources "/subtopics", SubtopicController
    resources "/contents", ContentController
  end

  # Email viewer route
  if Mix.env() == :dev do
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end

  # Authentication routes
  scope "/", DidataWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/login", UserSessionController, :new
    post "/users/login", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", DidataWeb do
    pipe_through [:browser, :require_authenticated_user]

    delete "/users/logout", UserSessionController, :delete
    get "/users/settings", UserSettingsController, :edit
    put "/users/settings/update_password", UserSettingsController, :update_password
    put "/users/settings/update_email", UserSettingsController, :update_email
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", DidataWeb do
    pipe_through [:browser]

    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :confirm
  end
end
