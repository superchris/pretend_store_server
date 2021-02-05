defmodule PretendStoreServerWeb.ProductView do
  use PretendStoreServerWeb, :view
  alias PretendStoreServerWeb.ProductView

  def render("index.json", %{
        entries: products,
        page_number: page_number,
        total_entries: total_entries,
        total_pages: total_pages
      }) do
    %{
      page_number: page_number,
      total_entries: total_entries,
      total_pages: total_pages,
      products: render_many(products, ProductView, "product.json")
    }
  end

  def render("show.json", %{product: product}) do
    %{product: render_one(product, ProductView, "product.json")}
  end

  def render("product.json", %{product: product}) do
    %{
      id: product.id,
      sku: product.sku,
      title: product.title,
      description: product.description,
      price: product.price
    }
  end
end
