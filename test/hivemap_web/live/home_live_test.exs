defmodule HivemapWeb.HomeLiveTest do
  use HivemapWeb.ConnCase

  import Phoenix.LiveViewTest

  test "GET / shows the map", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/")
    assert html =~ "Hivemap"
    assert html =~ "map-container"
  end
end
