defmodule PretendStoreServer.Factory do

  use ExMachina.Ecto, repo: PretendStoreServer.Repo

  alias PretendStoreServer.Products.Product

  def product_factory do
    %Product{
      title: Faker.Commerce.product_name(),
      description: Faker.Lorem.sentence(),
      price: Faker.Commerce.price() * 100 |> trunc,
    }
  end

end
