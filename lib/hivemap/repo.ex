defmodule Hivemap.Repo do
  use Ecto.Repo,
    otp_app: :hivemap,
    adapter: Ecto.Adapters.Postgres
end
