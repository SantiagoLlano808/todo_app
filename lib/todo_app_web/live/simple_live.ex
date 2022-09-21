defmodule TodoAppWeb.SimpleLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    socket = assign(socket, :message, "")
    {:ok, socket}
  end

  def handle_event("capture", %{"key" => _key, "value" => value}, socket) do
    socket = assign(socket, :message, value)
    {:noreply, socket}
  end
end
