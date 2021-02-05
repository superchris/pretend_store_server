defmodule PretendStoreServerWeb.ProductChannel do
  use PretendStoreServerWeb, :channel

  alias PretendStoreServer.Products

  alias PretendStoreServerWeb.ProductView

  @impl true
  def join("product:" <> product_id, _payload, socket) do
    send(self, :after_join)
    {:ok, socket |> assign(:product_id, product_id)}
  end

  def handle_info(:after_join, %{assigns: %{product_id: product_id}} = socket) do
    %{product: product} =
      ProductView.render("show.json", %{product: Products.get_product!(product_id)})

    state = %{cart: [], product: product}
    push(socket, "state:change", state)
    {:noreply, socket |> assign(:state, state)}
  end

  def handle_in("addProductToCart", product, %{assigns: %{state: %{cart: cart} = state}} = socket) do
    IO.inspect(product)
    new_state = %{state | cart: [product | cart]}

    push(socket, "state:change", new_state)
    {:noreply, socket |> assign(:state, new_state)}
  end
end
