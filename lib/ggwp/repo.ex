defmodule GGWP.Repo do
  use Ecto.Repo,
    otp_app: :ggwp,
    adapter: Ecto.Adapters.Postgres
end
