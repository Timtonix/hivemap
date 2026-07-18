defmodule HivemapWeb.UserSessionHTML do
  use HivemapWeb, :html

  embed_templates "user_session_html/*"

  defp local_mail_adapter? do
    Application.get_env(:hivemap, Hivemap.Mailer)[:adapter] == Swoosh.Adapters.Local
  end
end
