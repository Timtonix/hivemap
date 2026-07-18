defmodule HivemapWeb.PageController do
  use HivemapWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
