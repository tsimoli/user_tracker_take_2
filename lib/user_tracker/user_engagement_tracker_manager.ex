defmodule UserTracker.UserEngagementTrackerManager do
  use GenServer

  alias UserTracker.UserEngagementTracker

  # Client

  def start_link(state) do
    GenServer.start_link(
      __MODULE__,
      state
    )
  end

  def change_content_visibility(pid, content_visible) do
    GenServer.cast(pid, {:content_visible, content_visible})
  end

  # Server

  @impl true
  def init(state) do
    Process.flag(:trap_exit, true)
    UserEngagementTracker.start_link(state)
  end

  @impl true
  def handle_cast({:content_visible, content_visible}, pid) do
    GenServer.cast(pid, {:content_visible, content_visible})
    {:noreply, pid}
  end

  @impl true
  def handle_info(_, _) do
    {:noreply, :ok}
  end
end
