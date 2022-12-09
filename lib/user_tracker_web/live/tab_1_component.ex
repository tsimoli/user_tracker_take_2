defmodule UserTrackerWeb.Tab1Component do
  use UserTrackerWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="mt-8">
      <.link navigate={~p"/page_b"} class="font-semibold text-brand hover:underline">
        Page B
      </.link>
    </div>
    """
  end
end
