defmodule PretendStoreServerWeb.ProductListChannel do
  use PretendStoreServerWeb, :channel

  alias PretendStoreServer.Products

  alias PretendStoreServerWeb.ProductView

  @impl true
  def join("product_list:all", _payload, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  @impl true
  def handle_info(:after_join, socket) do
    %{products: products, total_pages: total_pages, page_number: page_number} = ProductView.render("index.json", Products.list_products())
    state = %{cart: [], products: products, total_pages: total_pages, page_number: page_number}
    push(socket, "state:change", state)
    {:noreply, socket |> assign(:state, state)}
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

  def handle_in("addProductToCart", product, %{assigns: %{state: %{cart: cart} = state}} = socket) do
    IO.inspect(product)
    new_state = %{state | cart: [product | cart]}

    push(socket, "state:change", new_state)
    {:noreply, socket |> assign(:state, new_state)}
  end

  def handle_in("changed", page, %{assigns: %{state: state}} = socket) do
    %{products: products, total_pages: total_pages, page_number: page_number} = ProductView.render("index.json", Products.list_products(page))
    new_state = %{state | products: products, page_number: page_number, total_pages: total_pages}
    push(socket, "state:change", new_state)
    {:noreply, socket |> assign(:state, new_state)}
  end
end
