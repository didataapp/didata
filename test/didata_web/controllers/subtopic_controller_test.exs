defmodule DidataWeb.Admin.SubtopicControllerTest do
  use DidataWeb.ConnCase, async: true

  defdelegate register_and_login_admin(conn), to: DidataWeb.ConnCase

  setup :register_and_login_admin

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all subtopics", %{conn: conn} do
      conn = get(conn, Routes.admin_subtopic_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Subtopics"
    end
  end

  describe "new subtopic" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.admin_subtopic_path(conn, :new))
      assert html_response(conn, 200) =~ "New Subtopic"
    end
  end

  describe "create subtopic" do
    test "redirects to show when data is valid", %{conn: conn} do
      topic = insert(:topic)

      conn =
        post(conn, Routes.admin_subtopic_path(conn, :create),
          subtopic: Map.merge(@create_attrs, %{topic_id: topic.id})
        )

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_subtopic_path(conn, :show, id)

      conn = get(conn, Routes.admin_subtopic_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Subtopic"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.admin_subtopic_path(conn, :create), subtopic: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Subtopic"
    end
  end

  describe "edit subtopic" do
    setup [:create_subtopic]

    test "renders form for editing chosen subtopic", %{conn: conn, subtopic: subtopic} do
      conn = get(conn, Routes.admin_subtopic_path(conn, :edit, subtopic))
      assert html_response(conn, 200) =~ "Edit Subtopic"
    end
  end

  describe "update subtopic" do
    setup [:create_subtopic]

    test "redirects when data is valid", %{conn: conn, subtopic: subtopic} do
      conn =
        put(conn, Routes.admin_subtopic_path(conn, :update, subtopic), subtopic: @update_attrs)

      assert redirected_to(conn) == Routes.admin_subtopic_path(conn, :show, subtopic)

      conn = get(conn, Routes.admin_subtopic_path(conn, :show, subtopic))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, subtopic: subtopic} do
      conn =
        put(conn, Routes.admin_subtopic_path(conn, :update, subtopic), subtopic: @invalid_attrs)

      assert html_response(conn, 200) =~ "Edit Subtopic"
    end
  end

  describe "delete subtopic" do
    setup [:create_subtopic]

    test "deletes chosen subtopic", %{conn: conn, subtopic: subtopic} do
      conn = delete(conn, Routes.admin_subtopic_path(conn, :delete, subtopic))
      assert redirected_to(conn) == Routes.admin_subtopic_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.admin_subtopic_path(conn, :show, subtopic))
      end
    end
  end

  defp create_subtopic(_) do
    {:ok, subtopic: insert(:subtopic)}
  end
end
