defmodule HivemapWeb.HomeLive do
  use HivemapWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_event("map-clicked", %{"lat" => lat, "lng" => lng}, socket) do
    # Handle the map-clicked event sent by our JS hook
    IO.inspect({lat, lng}, label: "Coordinates clicked on map")
    {:noreply, socket}
  end
end
