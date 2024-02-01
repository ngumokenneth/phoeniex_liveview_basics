defmodule LiveviewBasics.Repo.Migrations.User do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string
      add :name, :string
      add :password, :string
    end

    create unique_index(:users, [:email])
  end
end
