defmodule LiveviewBasics.Repo.Migrations.Product do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :category, :string
      add :sku, :string
      add :image, :string
    end
  end
end
