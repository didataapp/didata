defmodule DidataWeb.DisciplineController do
  use DidataWeb, :controller

  alias Didata.Studies

  def index(conn, _params) do
    disciplines = Studies.list_disciplines()
    render(conn, "index.html", disciplines: disciplines)
  end
end
