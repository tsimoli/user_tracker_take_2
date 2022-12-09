defmodule UserTrackerWeb.Tab2Component do
  use UserTrackerWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="mt-8">
      <.link navigate={~p"/page_a"} class="font-semibold text-brand hover:underline">
        Page A
      </.link>
    </div>
    """
  end
end
