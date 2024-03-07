defmodule LiveviewBasicsWeb.UserRegistrationLive do
  alias LiveviewBasics.Accounts
  alias LiveviewBasics.Accounts.UsersSchema
  use LiveviewBasicsWeb, :live_view

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def handle_params(_unsigned_params, _uri, socket) do
    {:noreply, prepare_socket_for_a_user(socket)}
  end

  @impl Phoenix.LiveView
  def handle_event("validate", %{"user" => user_params}, socket) do
    {:noreply, handle_validate(user_params, socket)}
  end

  def handle_event("submit", %{"user" => user_params}, socket) do
    {:noreply, handle_submit(user_params, socket)}
  end

  defp prepare_socket_for_a_user(socket) do
    changeset = Accounts.change_user()
    form = to_form(changeset, as: "user")
    assign(socket, :form, form)
  end

  defp handle_validate(
         %{"name" => _, "email" => _, "password" => _} = user_params,
         socket
       ) do
    changeset = Accounts.change_user(%UsersSchema{}, user_params)

    form = to_form(%{changeset | action: :validate}, as: "user")
    assign(socket, :form, form)
  end

  def handle_submit(user_params, socket) do
    case Accounts.register_user(user_params) do
      {:ok, _user} -> push_navigate(socket, to: ~p"/login")
      # {:error, :error} -> put_flash(socket, error: "registration failed")
    end
  end
end
