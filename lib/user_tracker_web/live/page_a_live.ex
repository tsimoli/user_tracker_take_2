defmodule UserTrackerWeb.PageALive do
  use UserTrackerWeb, :live_view

  def render(assigns) do
    ~H"""
    <div
      id="pageb"
      phx-hook="TrackHook"
      data-pageviewid={if assigns[:pageview_id], do: @pageview_id, else: "0"}
    >
      <h1 class="text-xl">Page A</h1>
      <div class="mt-8 flex space-x-4">
        <.link navigate={~p"/page_b"} class="font-semibold text-brand hover:underline">
          Page B
        </.link>
        <.link navigate={~p"/page_c/tab_1"} class="font-semibold text-brand hover:underline">
          Page C, Tab 1
        </.link>
      </div>
    </div>
    """
  end

  def handle_event(
        "content_visible",
        %{"content_visible" => content_visible},
        %{assigns: %{engagement_id: engagement_id}} = socket
      ) do
    UserTracker.UserEngagementTracker.change_content_visibility(engagement_id, content_visible)
    {:noreply, socket}
  end
end
