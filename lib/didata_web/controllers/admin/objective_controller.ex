defmodule DidataWeb.Admin.ObjectiveController do
  use DidataWeb, :controller

  alias Didata.Studies
  alias Didata.Studies.Objective

  def index(conn, _params) do
    objectives = Studies.list_objectives()
    render(conn, "index.html", objectives: objectives)
  end

  def new(conn, _params) do
    changeset = Studies.change_objective(%Objective{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"objective" => objective_params}) do
    case Studies.create_objective(objective_params) do
      {:ok, objective} ->
        conn
        |> put_flash(:info, "Objective created successfully.")
        |> redirect(to: Routes.objective_path(conn, :show, objective))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    objective = Studies.get_objective!(id)
    render(conn, "show.html", objective: objective)
  end

  def edit(conn, %{"id" => id}) do
    objective = Studies.get_objective!(id)
    changeset = Studies.change_objective(objective)
    render(conn, "edit.html", objective: objective, changeset: changeset)
  end

  def update(conn, %{"id" => id, "objective" => objective_params}) do
    objective = Studies.get_objective!(id)

    case Studies.update_objective(objective, objective_params) do
      {:ok, objective} ->
        conn
        |> put_flash(:info, "Objective updated successfully.")
        |> redirect(to: Routes.objective_path(conn, :show, objective))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", objective: objective, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    objective = Studies.get_objective!(id)
    {:ok, _objective} = Studies.delete_objective(objective)

    conn
    |> put_flash(:info, "Objective deleted successfully.")
    |> redirect(to: Routes.objective_path(conn, :index))
  end
end
