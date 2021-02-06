defmodule PretendStoreServerWeb.ProductListChannel do
  use PretendStoreServerWeb, :channel

  use LiveStateChannel

  alias PretendStoreServer.Products

  alias PretendStoreServerWeb.ProductView

  def init(_socket) do
    %{products: products, total_pages: total_pages, page_number: page_number} =
      ProductView.render("index.json", Products.list_products())

    %{cart: [], products: products, total_pages: total_pages, page_number: page_number}
  end

  def handle_event("addProductToCart", product, %{cart: cart} = state) do
    {:noreply, %{state | cart: [product | cart]}}
  end

  def handle_event("changed", page, state) do
    %{products: products, total_pages: total_pages, page_number: page_number} =
      ProductView.render("index.json", Products.list_products(page))

    {:noreply, %{state | products: products, page_number: page_number, total_pages: total_pages}}
  end
end
