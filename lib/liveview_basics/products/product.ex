defmodule LiveviewBasics.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "products" do
    field :name, :string
    field :category, :string
    field :sku, :string
    field :image, :string
  end

  def changeset(%__MODULE__{} = product, attrs \\ %{}) do
    product
    |> cast(attrs, [:name, :category, :sku, :image] )
    |> validate_required([:name, :category, :sku, :image])
  end
end
