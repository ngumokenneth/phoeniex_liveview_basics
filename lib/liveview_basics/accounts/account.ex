defmodule LiveviewBasics.Accounts do
  alias LiveviewBasics.Accounts.UsersSchema
  alias LiveviewBasics.Accounts.User.Query
  alias LiveviewBasics.Repo

  def register_user(attrs) do
    %UsersSchema{}
    |> UsersSchema.registration_changeset(attrs)
    |> Repo.insert()
  end

  def change_user(user \\ %UsersSchema{}, attrs \\ %{}) do
    UsersSchema.registration_changeset(user, attrs)
  end

  def login(%{"name" => _name, "email" => email, "password" => _password} = params) do
    with {:ok, user} <- user_with_email(email) do
      maybe_login_user(user, params)
    end
  end

  def user_with_email(email) do
    query = Query.with_email(email)
    user = Repo.one(query)

    if user do
      {:ok, user}
    else
      {:errror, :not_found}
    end
  end

  def maybe_login_user(user, %{"password" => password}) do
    similar? = user.password == password

    if similar?, do: {:ok, user}, else: {:error, "invalid_credentials"}
  end

  def change_user_login(user \\ %UsersSchema{}, attrs \\ %{}) do
    UsersSchema.login_changeset(user, attrs)
  end
end
