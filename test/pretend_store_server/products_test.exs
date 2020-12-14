defmodule PretendStoreServer.ProductsTest do
  use PretendStoreServer.DataCase

  alias PretendStoreServer.Products

  describe "products" do
    alias PretendStoreServer.Products.Product

    @valid_attrs %{description: "some description", price: 42, sku: "some sku", title: "some title"}
    @update_attrs %{description: "some updated description", price: 43, sku: "some updated sku", title: "some updated title"}
    @invalid_attrs %{description: nil, price: nil, sku: nil, title: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Products.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Products.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Products.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Products.create_product(@valid_attrs)
      assert product.description == "some description"
      assert product.price == 42
      assert product.sku == "some sku"
      assert product.title == "some title"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, %Product{} = product} = Products.update_product(product, @update_attrs)
      assert product.description == "some updated description"
      assert product.price == 43
      assert product.sku == "some updated sku"
      assert product.title == "some updated title"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_product(product, @invalid_attrs)
      assert product == Products.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Products.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Products.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Products.change_product(product)
    end
  end
end
