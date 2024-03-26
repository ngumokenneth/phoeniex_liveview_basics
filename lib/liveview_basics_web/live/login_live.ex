defmodule LiveviewBasicsWeb.LoginLive do
  alias LiveviewBasics.Accounts
  alias LiveviewBasics.Accounts.UsersSchema
  use LiveviewBasicsWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(_unsigned_params, _uri, socket) do
    {:noreply, prepare_socket_for_login(socket)}
  end

  def prepare_socket_for_login(socket) do
    changeset = Accounts.change_user_login()
    form = to_form(changeset, as: "login")

    assign(socket, :form, form)
  end

  @doc """
  A description of how the validate event occurs
  ----------------------------------------------
    => When a user triggers this event, in this case "validate", Liveview will create a parameters map.
      The map will contain keys for the event metadata/payload.
      KEYS: (1) "target" -> This is a keyword list of the last field name that triggered the event e,g "target" =>             ["attributes_key", "email"]
          (2) "attributes_key" -> This is the key that references the attributes map. e.g "attributes_key" => %{"email" => "ngumo@ngumo.com"}.

    => In a real world example, this is how it would look.

    def handle_event("validate", %{"user" => user_params}, socket) do
      {:noreply, handle_validate(user_params, socket)}
    end

    ===========================================

    From the above.
    Liveview will create a parameters map. The map will contain key "target"  and key "user".
    The target key will contain a keyword list of "user" key that references the user attributes map. it will also contain the field name that triggered the event. e.g "target" => ["user", "email"].

    The parameters map also contains the "user" key that references the user attributes map. e.g "user" => %{"email" => "ngumo@ngumo.com", "password" => "ngumo"}.
      iex: Parameters: %{"_target" => ["login", "email"], "user" => %{"email" => "ngumo@ngumo.com", "password" => "[FILTERED]"}}
  """
  def handle_event("validate", %{"user" => user_params}, socket) do
    {:noreply, handle_validate(user_params, socket)}
  end

  def handle_event("submit", %{"user" => user_params}, socket) do
    {:noreply, handle_submit(user_params, socket)}
  end

  defp handle_validate(
         %{"name" => _, "email" => _, "password" => _} = user_params,
         socket
       ) do
    changeset = Accounts.change_user_login(%UsersSchema{}, user_params)

    form = to_form(%{changeset | action: :validate}, as: "user")
    assign(socket, :form, form)
  end

  def handle_submit(user_params, socket) do
    case Accounts.login(user_params) do
      {:ok, _user} -> put_flash(socket, :message, "Ready for testing")
      {:error, _error} -> put_flash(socket, :error, "check logs for errors")
    end
  end
end
