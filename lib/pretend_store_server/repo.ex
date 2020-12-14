defmodule PretendStoreServer.Repo do
  use Ecto.Repo,
    otp_app: :pretend_store_server,
    adapter: Ecto.Adapters.Postgres
end
