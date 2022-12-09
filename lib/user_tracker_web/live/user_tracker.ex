defmodule UserTrackerWeb.UserTracker do
  import Phoenix.LiveView
  import Phoenix.Component

  alias UserTrackerWeb.PageCLive
  alias UserTracker.UserEngagementTracker

  def on_mount(:default, _params, %{"unique_id" => unique_id}, socket) do
    socket =
      if connected?(socket) do
        uuid = Ecto.UUID.generate()

        view = page_module(socket.view, socket.assigns.live_action)

        UserEngagementTracker.start_link([uuid, unique_id, view])
        socket |> assign(engagement_id: uuid)
      else
        socket
      end

    {:cont, socket}
  end

  defp page_module(view, live_action) do
    case {view, live_action} do
      {PageCLive, :tab1} -> UserTrackerWeb.Tab1Component
      {PageCLive, :tab2} -> UserTrackerWeb.Tab2Component
      _ -> view
    end
  end
end
