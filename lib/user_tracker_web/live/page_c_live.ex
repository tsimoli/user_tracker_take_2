defmodule UserTrackerWeb.PageCLive do
  use UserTrackerWeb, :live_view

  alias UserTrackerWeb.{Tab1Component, Tab2Component}

  def render(assigns) do
    ~H"""
    <div
      id="pagec"
      phx-hook="TrackHook"
      data-pageviewid={if assigns[:pageview_id], do: @pageview_id, else: "0"}
    >
      <h1 class="text-xl">Page C, <%= @tab_name %></h1>
      <nav class="mt-8 isolate flex divide-x divide-gray-200 rounded-lg shadow" aria-label="Tabs">
        <.link
          navigate={~p"/page_c/tab_1"}
          class={"#{if @live_action == :tab1, do: "text-gray-900", else: "text-gray-500 hover:text-gray-700"} group relative min-w-0 flex-1 overflow-hidden bg-white py-4 px-4 text-sm font-medium text-center hover:bg-gray-50 focus:z-10"}
        >
          Tab 1
          <span
            :if={@live_action == :tab1}
            aria-hidden="true"
            class="bg-brand absolute inset-x-0 bottom-0 h-0.5"
          >
          </span>
        </.link>

        <.link
          navigate={~p"/page_c/tab_2"}
          class={"#{if @live_action == :tab2, do: "text-gray-900", else: "text-gray-500 hover:text-gray-700"} group relative min-w-0 flex-1 overflow-hidden bg-white py-4 px-4 text-sm font-medium text-center hover:bg-gray-50 focus:z-10"}
        >
          Tab 2
          <span
            :if={@live_action == :tab2}
            aria-hidden="true"
            class="bg-brand absolute inset-x-0 bottom-0 h-0.5"
          >
          </span>
        </.link>
      </nav>
      <div>
        <%= case @live_action do %>
          <% :tab1 -> %>
            <.live_component module={Tab1Component} id="tab1" />
          <% :tab2 -> %>
            <.live_component module={Tab2Component} id="tab2" />
        <% end %>
      </div>
    </div>
    """
  end

  def mount(_params, _session, %{assigns: %{live_action: live_action}} = socket) do
    tab_name = map_live_action_to_tab_name(live_action)
    socket = socket |> assign(tab_name: tab_name, live_action: live_action)
    {:ok, socket}
  end

  defp map_live_action_to_tab_name(live_action) do
    case live_action do
      :tab1 -> "Tab 1"
      :tab2 -> "Tab 2"
    end
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
