defmodule PretendStoreServer.Repo do
  use Ecto.Repo,
    otp_app: :pretend_store_server,
    adapter: Ecto.Adapters.Postgres
  use Scrivener, page_size: 10
end
