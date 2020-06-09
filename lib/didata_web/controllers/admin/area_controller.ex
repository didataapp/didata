defmodule DidataWeb.Admin.AreaController do
  use DidataWeb, :controller

  alias Didata.Studies
  alias Didata.Studies.Area

  def index(conn, _params) do
    areas = Studies.list_areas()
    render(conn, "index.html", areas: areas)
  end

  def new(conn, _params) do
    changeset = Studies.change_area(%Area{})
    objectives = Studies.list_objectives()
    render(conn, "new.html", objectives: objectives, changeset: changeset)
  end

  def create(conn, %{"area" => area_params}) do
    case Studies.create_area(area_params) do
      {:ok, area} ->
        conn
        |> put_flash(:info, "Area created successfully.")
        |> redirect(to: Routes.admin_area_path(conn, :show, area))

      {:error, %Ecto.Changeset{} = changeset} ->
        objectives = Studies.list_objectives()
        render(conn, "new.html", objectives: objectives, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    area = Studies.get_area!(id)
    render(conn, "show.html", area: area)
  end

  def edit(conn, %{"id" => id}) do
    area = Studies.get_area!(id)
    changeset = Studies.change_area(area)
    objectives = Studies.list_objectives()

    render(conn, "edit.html", area: area, objectives: objectives, changeset: changeset)
  end

  def update(conn, %{"id" => id, "area" => area_params}) do
    area = Studies.get_area!(id)

    case Studies.update_area(area, area_params) do
      {:ok, area} ->
        conn
        |> put_flash(:info, "Area updated successfully.")
        |> redirect(to: Routes.admin_area_path(conn, :show, area))

      {:error, %Ecto.Changeset{} = changeset} ->
        objectives = Studies.list_objectives()
        render(conn, "edit.html", area: area, objectives: objectives, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    area = Studies.get_area!(id)
    {:ok, _area} = Studies.delete_area(area)

    conn
    |> put_flash(:info, "Area deleted successfully.")
    |> redirect(to: Routes.admin_area_path(conn, :index))
  end
end
