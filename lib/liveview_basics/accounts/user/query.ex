defmodule LiveviewBasics.Accounts.User.Query do
  @moduledoc """
  defines all queries for working with user schema
  """
  import Ecto.Query, only: [where: 3]

  alias LiveviewBasics.Accounts.UsersSchema

  def base, do: UsersSchema

  def with_email(query \\ base(), email) do
    where(query, [u], u.email == ^email)
  end
end
