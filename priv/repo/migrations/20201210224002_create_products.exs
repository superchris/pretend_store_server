defmodule PretendStoreServer.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :sku, :string
      add :title, :string
      add :description, :text
      add :price, :integer

      timestamps()
    end

  end
end
