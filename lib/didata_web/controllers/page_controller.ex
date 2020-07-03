defmodule DidataWeb.PageController do
  use DidataWeb, :controller

  alias Didata.Studies

  def index(conn, _params) do
    conn
    |> assign(:objectives, Studies.list_objectives())
    |> render("index.html")
  end
end
