defmodule DidataWeb.Admin.TopicController do
  use DidataWeb, :controller

  alias Didata.Studies
  alias Didata.Studies.Topic

  def index(conn, _params) do
    topics = Studies.list_topics()
    render(conn, "index.html", topics: topics)
  end

  def new(conn, _params) do
    changeset = Studies.change_topic(%Topic{})
    disciplines = Studies.list_disciplines()
    render(conn, "new.html", changeset: changeset, disciplines: disciplines)
  end

  def create(conn, %{"topic" => topic_params}) do
    case Studies.create_topic(topic_params) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic created successfully.")
        |> redirect(to: Routes.topic_path(conn, :show, topic))

      {:error, %Ecto.Changeset{} = changeset} ->
        disciplines = Studies.list_disciplines()
        render(conn, "new.html", changeset: changeset, disciplines: disciplines)
    end
  end

  def show(conn, %{"id" => id}) do
    topic = Studies.get_topic!(id)
    render(conn, "show.html", topic: topic)
  end

  def edit(conn, %{"id" => id}) do
    topic = Studies.get_topic!(id)
    changeset = Studies.change_topic(topic)
    disciplines = Studies.list_disciplines()
    render(conn, "edit.html", topic: topic, changeset: changeset, disciplines: disciplines)
  end

  def update(conn, %{"id" => id, "topic" => topic_params}) do
    topic = Studies.get_topic!(id)

    case Studies.update_topic(topic, topic_params) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic updated successfully.")
        |> redirect(to: Routes.topic_path(conn, :show, topic))

      {:error, %Ecto.Changeset{} = changeset} ->
        disciplines = Studies.list_disciplines()
        render(conn, "edit.html", topic: topic, changeset: changeset, disciplines: disciplines)
    end
  end

  def delete(conn, %{"id" => id}) do
    topic = Studies.get_topic!(id)
    {:ok, _topic} = Studies.delete_topic(topic)

    conn
    |> put_flash(:info, "Topic deleted successfully.")
    |> redirect(to: Routes.topic_path(conn, :index))
  end
end
