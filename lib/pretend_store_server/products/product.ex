defmodule PretendStoreServer.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :description, :string
    field :price, :integer
    field :sku, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:sku, :title, :description, :price])
    |> validate_required([:sku, :title, :description, :price])
  end
end
