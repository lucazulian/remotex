defmodule Remotex.Repo do
  use Ecto.Repo,
    otp_app: :remotex,
    adapter: Ecto.Adapters.Postgres
end
