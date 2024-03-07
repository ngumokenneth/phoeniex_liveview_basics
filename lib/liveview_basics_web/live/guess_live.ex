defmodule LiveviewBasicsWeb.GuessLive do
  use LiveviewBasicsWeb, :live_view

  def render(assigns) do
    ~H"""
    <h1 class="text-3xl font-bold text-gray-950">Your Score: <%= @score %></h1>

    <div class="mt-3">
      <%= for num <- 1..10  do %>
        <.link
          class="px-4 py-3 mx-2 font-bold bg-gray-300 border"
          phx-click="guess"
          phx-value-number={num}
        >
          <%= num %>
        </.link>
      <% end %>
    </div>
    """
  end

  @doc """
    This is a documentation of liveview and it's structure & operation.

    What liveview is NOT!!!!

    => In some languages, once event X (e.g click event) is invoked changed Y on the web page.

    What is Liveview.

    => Liveview is a web development framework that enables rich real-time user experience through server rendered HTML.
    => Liveviews are process that receive events, change state and render the changed state.
    => Once an event X is invoked (e.g Validate) a message is sent to the server to change the state of Y and render the new state of Y.



    => The state is an immutable data-structure e.g socket which is a struct
    => Events can be triggered in two ways:
        (1) internally -> this is through messages by Phoenix.PubSub
        (2) externally -> this is through a client/browser
    => Liveviews are first rendered as static pages through a HTTP connection/request. The HTTP connection is then upgraded to a permanent/persistent web-socket connection.

    => Liveview implements a series of functions as callbacks.
    (1) mount(params, session, socket)
    -> This function accepts 3 arguments: params, session & socket
        (i) params -> contains information about the request and can be used to read information from the URL.
        (ii) session -> contains information about the current user
        (iii) socket -> This is a struct that holds the state of the liveview.
    -> The return value of mount is {:ok, socket}

    (2) handle_params(params, session, socket)

    (3) handle_event(event, session, socket)
        => handle_event callbacks are invoked by user activity, the event is then sent to the server which is matched to a handle_event callback. The callback function handles the data manipulation and updates the socket. The return value is {:noreply, socket} tuple.

    (4) render(assigns)
        => the render callback is invoked to display data in the socket assigns map.
        => One can use the ~H sigil or create a liveview_name_live.html.heex template file to render the data.
    (5) handle_info(;event, socket)
        => this callback function receives an event and a socket.
        => it's used to handle internal messages.

    Liveview NAVIGATION

    => Liveview enables one to move/navigate to different liveviews without a full page reload.
    => One can either patch the current liveview and update the URL OR navigate to a new liveview

    COMPONENTS

    => Liveview supports 2 types of components.
    (i) Live_components(stateful components) -> Used when you want to move part of the state or part of the events in your liveview to a separate module.
    -> Live_components have their own mount/1 and handle_event/3 call_backs
    -> Live_components run in the same process as the parent liveview

    (ii) Function_component(stateless components)
    =>   They are used to when one wants to reuse markup
    =>  function_components accepts an assigns map similar to render.


  NOTE: One can render a liveview inside another liveview through live_render/3 function.

  """

  def mount(_params, _session, socket) do
    {:ok, assign(socket, score: 0, correct_guess: 5)}
  end

  def handle_event("guess", %{"number" => num}, socket) do
    IO.inspect(socket, label: "socket value")
    score = socket.assigns.score

    if socket.assigns.correct_guess == String.to_integer(num) do
      {:noreply, assign(socket, :score, score + 1)}
    else
      {:noreply, assign(socket, :score, score - 1)}
    end
  end
end
