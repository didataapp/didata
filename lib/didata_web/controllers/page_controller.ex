defmodule DidataWeb.PageController do
  use DidataWeb, :controller

  alias Didata.Studies

  def index(conn, _params) do
    conn
    |> assign(:objectives, Studies.list_objectives())
    |> render("index.html")
  end

  def objective(conn, %{"objective_id" => objective_id}) do
    {id, ""} = Integer.parse(objective_id)
    objective = Studies.get_objective(id)

    conn
    |> assign(:objective, objective)
    |> render("objective.html")
  end

  def area(conn, %{"area_id" => area_id}) do
    {id, ""} = Integer.parse(area_id)
    area = Studies.get_area(id)

    conn
    |> assign(:area, area)
    |> render("area.html")
  end
end
