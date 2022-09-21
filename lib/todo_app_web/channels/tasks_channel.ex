defmodule TodoAppWeb.TasksChannel do
  use TodoAppWeb, :channel

  @impl true
  def join("tasks:" <> _id, payload, socket) do
    IO.inspect(payload, label: "PAYLOAD: ")

    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (tasks:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  @impl true
  def handle_in(_, payload, socket) do
    #  IO.inspect(binding(), label: "HANDLE_IN")
    # broadcast(socket, "shout", payload)
    broadcast(socket, "new_msg", payload)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
