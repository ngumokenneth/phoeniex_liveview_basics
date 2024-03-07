defmodule Forms.Factory do
  use ExMachina.Ecto, repo: LiveviewBasics.Repo

  alias LiveviewBasics.Accounts.User
  alias FakerElixir, as: Faker

  def user_factory do
    %User{
      email: Faker.Internet.email()
    }
  end
end
