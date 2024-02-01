defmodule LiveviewBasics.Accounts.User do
  defstruct [:email]
  @types %{email: :string}
  import Ecto.Changeset

  def changeset(%__MODULE__{} = user, attrs) do
    {user, @types}
    |> cast(attrs, Map.keys(@types))
    |> validate_required([:email])
    |> validate_format(:email, ~r/@/)
  end

  def change_user(%__MODULE__{} = user, attrs \\ %{}) do
    changeset(user, attrs)
  end
end
