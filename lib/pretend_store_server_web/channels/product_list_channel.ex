defmodule PretendStoreServerWeb.ProductListChannel do
  use PretendStoreServerWeb, :channel

  alias PretendStoreServer.Products

  alias PretendStoreServerWeb.ProductView

  @impl true
  def join("product_list:all", _payload, socket) do
    reply = ProductView.render("index.json", %{products: Products.list_products()})
    {:ok, reply, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (product_list:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  def handle_in("addProductToCart", product, %{assigns: %{cart: cart}} = socket) do
    IO.inspect(product)
    changed_cart = [product | cart]
    push(socket, "cart:change", %{cart: changed_cart})
    {:noreply, socket |> assign(:cart, changed_cart)}
  end

  def handle_in("addProductToCart", product, socket) do
    IO.inspect(product)
    push(socket, "cart:change", %{cart: [product]})
    {:noreply, socket |> assign(:cart, [product])}
  end
end
