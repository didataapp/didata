defmodule DidataWeb.Admin.AreaControllerTest do
  use DidataWeb.ConnCase, async: true

  defdelegate register_and_login_admin(conn), to: DidataWeb.ConnCase

  setup :register_and_login_admin

  @create_attrs %{name: "some name", number: 42}
  @update_attrs %{name: "some updated name", number: 43}
  @invalid_attrs %{name: nil, number: nil, objective_id: nil}

  describe "index" do
    test "lists all areas", %{conn: conn} do
      conn = get(conn, Routes.admin_area_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Areas"
    end
  end

  describe "new area" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.admin_area_path(conn, :new))
      assert html_response(conn, 200) =~ "New Area"
    end
  end

  describe "create area" do
    test "redirects to show when data is valid", %{conn: conn} do
      objective = insert(:objective)

      conn =
        post(conn, Routes.admin_area_path(conn, :create),
          area: Map.merge(@create_attrs, %{objective_id: objective.id})
        )

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_area_path(conn, :show, id)

      conn = get(conn, Routes.admin_area_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Area"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.admin_area_path(conn, :create), area: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Area"
    end
  end

  describe "edit area" do
    setup [:create_area]

    test "renders form for editing chosen area", %{conn: conn, area: area} do
      conn = get(conn, Routes.admin_area_path(conn, :edit, area))
      assert html_response(conn, 200) =~ "Edit Area"
    end
  end

  describe "update area" do
    setup [:create_area]

    test "redirects when data is valid", %{conn: conn, area: area} do
      conn = put(conn, Routes.admin_area_path(conn, :update, area), area: @update_attrs)
      assert redirected_to(conn) == Routes.admin_area_path(conn, :show, area)

      conn = get(conn, Routes.admin_area_path(conn, :show, area))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, area: area} do
      conn = put(conn, Routes.admin_area_path(conn, :update, area), area: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Area"
    end
  end

  describe "delete area" do
    setup [:create_area]

    test "deletes chosen area", %{conn: conn, area: area} do
      conn = delete(conn, Routes.admin_area_path(conn, :delete, area))
      assert redirected_to(conn) == Routes.admin_area_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.admin_area_path(conn, :show, area))
      end
    end
  end

  defp create_area(_) do
    {:ok, area: insert(:area)}
  end
end
