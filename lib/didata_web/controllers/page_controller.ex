defmodule DidataWeb.PageController do
  use DidataWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
