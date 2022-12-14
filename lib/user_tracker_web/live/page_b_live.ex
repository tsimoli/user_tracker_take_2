defmodule UserTrackerWeb.PageBLive do
  use UserTrackerWeb, :live_view

  def render(assigns) do
    ~H"""
    <div
      id="pageb"
      phx-hook="TrackHook"
      data-pageviewid={if assigns[:pageview_id], do: @pageview_id, else: "0"}
    >
      <h1 class="text-xl">Page B</h1>
      <div class="mt-8 flex space-x-4">
        <.link navigate={~p"/page_a"} class="font-semibold text-brand hover:underline">
          Page A
        </.link>
        <.link navigate={~p"/page_c/tab_2"} class="font-semibold text-brand hover:underline">
          Page C, Tab 2
        </.link>
      </div>
    </div>
    """
  end
end
