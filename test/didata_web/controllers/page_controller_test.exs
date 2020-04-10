defmodule DidataWeb.PageControllerTest do
  use DidataWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Phoenix + Bulma + Font Awesome"
  end
end
