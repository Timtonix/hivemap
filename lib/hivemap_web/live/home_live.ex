defmodule HivemapWeb.HomeLive do
  use HivemapWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:show_login_modal?, false)
      # Interface de carte
      |> assign(:adding_spot?, false)
      |> assign(:temp_coords, nil)
      |> assign(:form, to_form(%{"name" => "", "description" => ""}))

    {:ok, socket}
  end

  def handle_event("map-clicked", %{"lat" => lat, "lng" => lng}, socket) do
    if socket.assigns.adding_spot? do
      # Si on est en mode ajout, on stocke les coordonnées et on ouvre la modale
      {:noreply, assign(socket, :temp_coords, %{lat: lat, lng: lng})}
    else
      # Sinon, on ne fait rien ou on affiche juste un log
      {:noreply, socket}
    end
  end

  def handle_event("start-adding-spot", _params, socket) do
    {:noreply, assign(socket, :adding_spot?, true)}
  end

  def handle_event("cancel-adding-spot", _params, socket) do
    {:noreply,
     socket
     |> assign(:adding_spot?, false)
     |> assign(:temp_coords, nil)}
  end

  def handle_event("save-spot", %{"name" => name, "description" => description}, socket) do
    coords = socket.assigns.temp_coords

    # 1. TODO: Enregistrer coords.lat, coords.lng, name et description en BDD

    # 2. Envoyer le nouveau marqueur à la carte via push_event
    socket =
      push_event(socket, "load-markers", %{
        spots: [%{lat: coords.lat, lng: coords.lng, name: name, description: description}]
      })

    {:noreply,
     socket
     |> assign(:adding_spot?, false)
     |> assign(:temp_coords, nil)
     |> put_flash(:info, "Localisation ajoutée avec succès !")}
  end

  def handle_event("login-click", _unsigned_params, socket) do
    {:noreply, update(socket, :show_login_modal?, &(!&1))}
  end

  def handle_info({:to_flash, message}, socket) do
    {:noreply,
     socket
     |> assign(:show_login_modal?, false)
     |> put_flash(:info, message)}
  end
end
