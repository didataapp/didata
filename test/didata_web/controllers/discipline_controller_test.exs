defmodule DidataWeb.Admin.DisciplineControllerTest do
  use DidataWeb.ConnCase, async: true

  defdelegate register_and_login_admin(conn), to: DidataWeb.ConnCase

  setup :register_and_login_admin

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all disciplines", %{conn: conn} do
      conn = get(conn, Routes.admin_discipline_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Disciplines"
    end
  end

  describe "new discipline" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.admin_discipline_path(conn, :new))
      assert html_response(conn, 200) =~ "New Discipline"
    end
  end

  describe "create discipline" do
    test "redirects to show when data is valid", %{conn: conn} do
      area = insert(:area)

      conn =
        post(conn, Routes.admin_discipline_path(conn, :create),
          discipline: Map.merge(@create_attrs, %{area_id: area.id})
        )

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_discipline_path(conn, :show, id)

      conn = get(conn, Routes.admin_discipline_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Discipline"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.admin_discipline_path(conn, :create), discipline: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Discipline"
    end
  end

  describe "edit discipline" do
    setup [:create_discipline]

    test "renders form for editing chosen discipline", %{conn: conn, discipline: discipline} do
      conn = get(conn, Routes.admin_discipline_path(conn, :edit, discipline))
      assert html_response(conn, 200) =~ "Edit Discipline"
    end
  end

  describe "update discipline" do
    setup [:create_discipline]

    test "redirects when data is valid", %{conn: conn, discipline: discipline} do
      conn =
        put(conn, Routes.admin_discipline_path(conn, :update, discipline),
          discipline: @update_attrs
        )

      assert redirected_to(conn) == Routes.admin_discipline_path(conn, :show, discipline)

      conn = get(conn, Routes.admin_discipline_path(conn, :show, discipline))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, discipline: discipline} do
      conn =
        put(conn, Routes.admin_discipline_path(conn, :update, discipline),
          discipline: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Discipline"
    end
  end

  describe "delete discipline" do
    setup [:create_discipline]

    test "deletes chosen discipline", %{conn: conn, discipline: discipline} do
      conn = delete(conn, Routes.admin_discipline_path(conn, :delete, discipline))
      assert redirected_to(conn) == Routes.admin_discipline_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.admin_discipline_path(conn, :show, discipline))
      end
    end
  end

  defp create_discipline(_) do
    {:ok, discipline: insert(:discipline)}
  end
end
