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

  def discipline(conn, %{"discipline_id" => discipline_id}) do
    {id, ""} = Integer.parse(discipline_id)
    discipline = Studies.get_discipline(id)

    conn
    |> assign(:discipline, discipline)
    |> render("discipline.html")
  end

  def topic(conn, %{"topic_id" => topic_id}) do
    {id, ""} = Integer.parse(topic_id)
    topic = Studies.get_topic(id)

    conn
    |> assign(:topic, topic)
    |> render("topic.html")
  end

  def subtopic(conn, %{"subtopic_id" => subtopic_id}) do
    {id, ""} = Integer.parse(subtopic_id)
    subtopic = Studies.get_subtopic(id)

    conn
    |> assign(:subtopic, subtopic)
    |> render("subtopic.html")
  end
end
