defmodule DidataWeb.Admin.ContentController do
  use DidataWeb, :controller

  alias Didata.Studies
  alias Didata.Studies.Content

  def index(conn, _params) do
    contents = Studies.list_contents()
    render(conn, "index.html", contents: contents)
  end

  def new(conn, _params) do
    changeset = Studies.change_content(%Content{})
    subtopics = Studies.list_subtopics()

    render(conn, "new.html",
      changeset: changeset,
      subtopics: subtopics,
      types: Studies.content_types()
    )
  end

  def create(conn, %{"content" => content_params}) do
    case Studies.create_content(content_params) do
      {:ok, content} ->
        conn
        |> put_flash(:info, "Content created successfully.")
        |> redirect(to: Routes.content_path(conn, :show, content))

      {:error, %Ecto.Changeset{} = changeset} ->
        subtopics = Studies.list_subtopics()

        render(conn, "new.html",
          changeset: changeset,
          subtopics: subtopics,
          types: Studies.content_types()
        )
    end
  end

  def show(conn, %{"id" => id}) do
    content = Studies.get_content!(id)
    render(conn, "show.html", content: content)
  end

  def edit(conn, %{"id" => id}) do
    content = Studies.get_content!(id)
    changeset = Studies.change_content(content)
    subtopics = Studies.list_subtopics()

    render(conn, "edit.html",
      content: content,
      changeset: changeset,
      subtopics: subtopics,
      types: Studies.content_types()
    )
  end

  def update(conn, %{"id" => id, "content" => content_params}) do
    content = Studies.get_content!(id)

    case Studies.update_content(content, content_params) do
      {:ok, content} ->
        conn
        |> put_flash(:info, "Content updated successfully.")
        |> redirect(to: Routes.content_path(conn, :show, content))

      {:error, %Ecto.Changeset{} = changeset} ->
        subtopics = Studies.list_subtopics()

        render(conn, "edit.html",
          content: content,
          changeset: changeset,
          subtopics: subtopics,
          types: Studies.content_types()
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    content = Studies.get_content!(id)
    {:ok, _content} = Studies.delete_content(content)

    conn
    |> put_flash(:info, "Content deleted successfully.")
    |> redirect(to: Routes.content_path(conn, :index))
  end
end
