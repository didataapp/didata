defmodule DidataWeb.Admin.DisciplineController do
  use DidataWeb, :controller

  alias Didata.Studies
  alias Didata.Studies.Discipline

  def index(conn, _params) do
    disciplines = Studies.list_disciplines()
    render(conn, "index.html", disciplines: disciplines)
  end

  def new(conn, _params) do
    changeset = Studies.change_discipline(%Discipline{})
    areas = Studies.list_areas()
    render(conn, "new.html", changeset: changeset, areas: areas)
  end

  def create(conn, %{"discipline" => discipline_params}) do
    case Studies.create_discipline(discipline_params) do
      {:ok, discipline} ->
        conn
        |> put_flash(:info, "Discipline created successfully.")
        |> redirect(to: Routes.admin_discipline_path(conn, :show, discipline))

      {:error, %Ecto.Changeset{} = changeset} ->
        areas = Studies.list_areas()
        render(conn, "new.html", changeset: changeset, areas: areas)
    end
  end

  def show(conn, %{"id" => id}) do
    discipline = Studies.get_discipline!(id)
    render(conn, "show.html", discipline: discipline)
  end

  def edit(conn, %{"id" => id}) do
    discipline = Studies.get_discipline!(id)
    changeset = Studies.change_discipline(discipline)
    areas = Studies.list_areas()
    render(conn, "edit.html", discipline: discipline, changeset: changeset, areas: areas)
  end

  def update(conn, %{"id" => id, "discipline" => discipline_params}) do
    discipline = Studies.get_discipline!(id)

    case Studies.update_discipline(discipline, discipline_params) do
      {:ok, discipline} ->
        conn
        |> put_flash(:info, "Discipline updated successfully.")
        |> redirect(to: Routes.admin_discipline_path(conn, :show, discipline))

      {:error, %Ecto.Changeset{} = changeset} ->
        areas = Studies.list_areas()
        render(conn, "edit.html", discipline: discipline, changeset: changeset, areas: areas)
    end
  end

  def delete(conn, %{"id" => id}) do
    discipline = Studies.get_discipline!(id)
    {:ok, _discipline} = Studies.delete_discipline(discipline)

    conn
    |> put_flash(:info, "Discipline deleted successfully.")
    |> redirect(to: Routes.admin_discipline_path(conn, :index))
  end
end
