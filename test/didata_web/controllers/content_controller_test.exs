defmodule DidataWeb.ContentControllerTest do
  use DidataWeb.ConnCase, async: true

  @create_attrs %{name: "some name", type: "video", url: "some url"}
  @update_attrs %{name: "some updated name", type: "text", url: "some updated url"}
  @invalid_attrs %{name: nil, type: nil, url: nil}

  describe "index" do
    test "lists all contents", %{conn: conn} do
      conn = get(conn, Routes.content_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Contents"
    end
  end

  describe "new content" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.content_path(conn, :new))
      assert html_response(conn, 200) =~ "New Content"
    end
  end

  describe "create content" do
    test "redirects to show when data is valid", %{conn: conn} do
      subtopic = insert(:subtopic)

      conn =
        post(conn, Routes.content_path(conn, :create),
          content: Map.merge(@create_attrs, %{subtopic_id: subtopic.id})
        )

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.content_path(conn, :show, id)

      conn = get(conn, Routes.content_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Content"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.content_path(conn, :create), content: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Content"
    end
  end

  describe "edit content" do
    setup [:create_content]

    test "renders form for editing chosen content", %{conn: conn, content: content} do
      conn = get(conn, Routes.content_path(conn, :edit, content))
      assert html_response(conn, 200) =~ "Edit Content"
    end
  end

  describe "update content" do
    setup [:create_content]

    test "redirects when data is valid", %{conn: conn, content: content} do
      conn = put(conn, Routes.content_path(conn, :update, content), content: @update_attrs)
      assert redirected_to(conn) == Routes.content_path(conn, :show, content)

      conn = get(conn, Routes.content_path(conn, :show, content))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, content: content} do
      conn = put(conn, Routes.content_path(conn, :update, content), content: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Content"
    end
  end

  describe "delete content" do
    setup [:create_content]

    test "deletes chosen content", %{conn: conn, content: content} do
      conn = delete(conn, Routes.content_path(conn, :delete, content))
      assert redirected_to(conn) == Routes.content_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.content_path(conn, :show, content))
      end
    end
  end

  defp create_content(_) do
    {:ok, content: insert(:content)}
  end
end
