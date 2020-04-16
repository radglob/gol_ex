defmodule GolExWeb.GameOfLifeLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <label>Counter: <%= @count %></label>
    <button phx-click="inc">+</button>
    """
  end

  def mount(_params, _session, socket) do
    socket = assign(socket, :count, 0)
    {:ok, socket}
  end

  def handle_event("inc", _event, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end
end
