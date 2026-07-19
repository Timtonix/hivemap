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
      <.modal id="login-modal-overlay" show={true} on_close={JS.push("login-click")}>
        <h3 class="text-lg font-bold tracking-tight pr-6">Connexion</h3>
        <p class="text-xs text-base-content/60 mb-4">
          Un lien de connexion vous sera envoyé par mail.
        </p>

        <.form
          for={@form}
          id="login-form"
          phx-submit="submitted"
          phx-target={@myself}
          class="space-y-4"
        >
          <.input
            field={@form[:email]}
            type="email"
            label="Email"
            placeholder="votre@email.com"
            autocomplete="username"
            spellcheck="false"
            required
            phx-mounted={JS.focus()}
          />
          <.button class="btn btn-primary w-full">
            Se connecter avec un mail
          </.button>
        </.form>
      </.modal>
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
