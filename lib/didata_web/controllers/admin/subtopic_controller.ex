defmodule DidataWeb.Admin.SubtopicController do
  use DidataWeb, :controller

  alias Didata.Studies
  alias Didata.Studies.Subtopic

  def index(conn, _params) do
    subtopics = Studies.list_subtopics()
    render(conn, "index.html", subtopics: subtopics)
  end

  def new(conn, _params) do
    topics = Studies.list_topics()
    changeset = Studies.change_subtopic(%Subtopic{})
    render(conn, "new.html", changeset: changeset, topics: topics)
  end

  def create(conn, %{"subtopic" => subtopic_params}) do
    case Studies.create_subtopic(subtopic_params) do
      {:ok, subtopic} ->
        conn
        |> put_flash(:info, "Subtopic created successfully.")
        |> redirect(to: Routes.admin_subtopic_path(conn, :show, subtopic))

      {:error, %Ecto.Changeset{} = changeset} ->
        topics = Studies.list_topics()
        render(conn, "new.html", changeset: changeset, topics: topics)
    end
  end

  def show(conn, %{"id" => id}) do
    subtopic = Studies.get_subtopic!(id)
    render(conn, "show.html", subtopic: subtopic)
  end

  def edit(conn, %{"id" => id}) do
    topics = Studies.list_topics()
    subtopic = Studies.get_subtopic!(id)
    changeset = Studies.change_subtopic(subtopic)
    render(conn, "edit.html", subtopic: subtopic, changeset: changeset, topics: topics)
  end

  def update(conn, %{"id" => id, "subtopic" => subtopic_params}) do
    subtopic = Studies.get_subtopic!(id)

    case Studies.update_subtopic(subtopic, subtopic_params) do
      {:ok, subtopic} ->
        conn
        |> put_flash(:info, "Subtopic updated successfully.")
        |> redirect(to: Routes.admin_subtopic_path(conn, :show, subtopic))

      {:error, %Ecto.Changeset{} = changeset} ->
        topics = Studies.list_topics()
        render(conn, "edit.html", subtopic: subtopic, changeset: changeset, topics: topics)
    end
  end

  def delete(conn, %{"id" => id}) do
    subtopic = Studies.get_subtopic!(id)
    {:ok, _subtopic} = Studies.delete_subtopic(subtopic)

    conn
    |> put_flash(:info, "Subtopic deleted successfully.")
    |> redirect(to: Routes.admin_subtopic_path(conn, :index))
  end
end
