defmodule DidataWeb.Admin.ObjectiveControllerTest do
  use DidataWeb.ConnCase, async: true

  defdelegate register_and_login_admin(conn), to: DidataWeb.ConnCase

  setup :register_and_login_admin

  @create_attrs %{name: "ENEM"}
  @update_attrs %{name: "ENEM 2021"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all objectives", %{conn: conn} do
      conn = get(conn, Routes.admin_objective_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Objectives"
    end
  end

  describe "new objective" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.admin_objective_path(conn, :new))
      assert html_response(conn, 200) =~ "New Objective"
    end
  end

  describe "create objective" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.admin_objective_path(conn, :create), objective: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_objective_path(conn, :show, id)

      conn = get(conn, Routes.admin_objective_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Objective"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.admin_objective_path(conn, :create), objective: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Objective"
    end
  end

  describe "edit objective" do
    setup [:create_objective]

    test "renders form for editing chosen objective", %{conn: conn, objective: objective} do
      conn = get(conn, Routes.admin_objective_path(conn, :edit, objective))
      assert html_response(conn, 200) =~ "Edit Objective"
    end
  end

  describe "update objective" do
    setup [:create_objective]

    test "redirects when data is valid", %{conn: conn, objective: objective} do
      conn =
        put(conn, Routes.admin_objective_path(conn, :update, objective), objective: @update_attrs)

      assert redirected_to(conn) == Routes.admin_objective_path(conn, :show, objective)

      conn = get(conn, Routes.admin_objective_path(conn, :show, objective))
      assert html_response(conn, 200) =~ "ENEM 2021"
    end

    test "renders errors when data is invalid", %{conn: conn, objective: objective} do
      conn =
        put(conn, Routes.admin_objective_path(conn, :update, objective), objective: @invalid_attrs)

      assert html_response(conn, 200) =~ "Edit Objective"
    end
  end

  describe "delete objective" do
    setup [:create_objective]

    test "deletes chosen objective", %{conn: conn, objective: objective} do
      conn = delete(conn, Routes.admin_objective_path(conn, :delete, objective))
      assert redirected_to(conn) == Routes.admin_objective_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.admin_objective_path(conn, :show, objective))
      end
    end
  end

  defp create_objective(_) do
    {:ok, objective: insert(:objective)}
  end
end
