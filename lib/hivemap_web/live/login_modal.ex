defmodule HivemapWeb.LoginModal do
  use HivemapWeb, :live_component
  alias Hivemap.Accounts

  def mount(socket) do
    {:ok,
     socket
     |> assign(:form, to_form(%{"email" => ""}))}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.form for={@form} id="login-modal" phx-submit="submitted" phx-target={@myself}>
        <.input
          field={@form[:email]}
          type="email"
          label="Email"
          autocomplete="username"
          spellcheck="false"
          required
          phx-mounted={JS.focus()}
        />
        <.button>
          Se connecter avec un mail
        </.button>
      </.form>
    </div>
    """
  end

  def handle_event("submitted", %{"email" => email}, socket) do
    if user = Accounts.get_user_by_email(email) do
      Accounts.deliver_login_instructions(
        user,
        &url(~p"/users/log-in/#{&1}")
      )
    end

    send(
      self(),
      {:to_flash,
       "Si vous avez un compte, vous allez recevoir un mail pour finir votre connexion"}
    )

    {:noreply, socket}
  end
end
