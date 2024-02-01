defmodule LiveviewBasics.Players.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    field :first_name, :string
    field :last_name, :string
    field :age, :integer
    field :kit_number, :integer
    field :team, :string
    field :height, :float
    field :rating, :float
    field :position, :string
  end

  def changeset(%__MODULE__{} = player, attrs \\ %{}) do
    player
    |> cast(attrs, [
      :first_name,
      :last_name,
      :age,
      :kit_number,
      :team,
      :height,
      :rating,
      :position
    ])
    |> validate_required([
      :first_name,
      :last_name,
      :age,
      :kit_number,
      :team,
      :height,
      :rating,
      :position
    ])
    |> unique_constraint([:first_name, :last_name])
  end
end
