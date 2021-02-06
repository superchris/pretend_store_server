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
    state = init(socket)
    push(socket, "state:change", state)
    {:noreply, socket |> assign(:state, state)}
  end

  def init(_socket) do
    %{products: products, total_pages: total_pages, page_number: page_number} =
      ProductView.render("index.json", Products.list_products())
    %{cart: [], products: products, total_pages: total_pages, page_number: page_number}
  end

  @impl true
  def handle_in("lvs_evt:" <> event_name, payload, %{assigns: %{state: state}} = socket) do
    case handle_event(event_name, payload, state) do
      {:noreply, new_state} ->
        push(socket, "state:change", new_state)
        {:noreply, socket |> assign(:state, new_state)}
    end
  end

  def handle_event("addProductToCart", product, %{cart: cart} = state) do
    {:noreply, %{state | cart: [product | cart]} }
  end

  def handle_event("changed", page, state) do
    %{products: products, total_pages: total_pages, page_number: page_number} =
      ProductView.render("index.json", Products.list_products(page))

    {:noreply, %{state | products: products, page_number: page_number, total_pages: total_pages}}
  end
end
