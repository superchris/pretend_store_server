defmodule PretendStoreServerWeb.PageController do
  use PretendStoreServerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
