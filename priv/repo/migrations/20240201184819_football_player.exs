defmodule LiveviewBasics.Repo.Migrations.FootballPlayer do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :first_name, :string
      add :last_name, :string
      add :age, :integer
      add :kit_number, :integer
      add :team, :string
      add :height, :float
      add :rating, :float
      add :position, :string
    end

    create unique_index(:players, [:first_name, :last_name])
  end
end
