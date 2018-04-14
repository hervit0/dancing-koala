defmodule KoalaWeb.PageControllerTest do
  use KoalaWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    response = html_response(conn, 200)

    assert response =~ "Get started by entering your creds below."
    assert response =~ "Welcome to Senzual Night event tracker!"
  end
end
