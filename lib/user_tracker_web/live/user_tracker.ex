defmodule UserTrackerWeb.UserTracker do
  import Phoenix.LiveView
  import Phoenix.Component

  alias UserTrackerWeb.PageCLive
  alias UserTracker.UserEngagementTracker
  alias UserTracker.UserEngagementTrackerManager

  def on_mount(:default, _params, %{"unique_id" => unique_id}, socket) do
    socket =
      if connected?(socket) do
        view = page_module(socket.view, socket.assigns.live_action)

        case UserEngagementTrackerManager.start_link([unique_id, view]) do
          {:ok, pid} ->
            socket |> assign(engagement_pid: pid)

            attach_hook(socket, :user_engagement_events, :handle_event, fn
              "content_visible", %{"content_visible" => content_visible}, socket ->
                UserTracker.UserEngagementTrackerManager.change_content_visibility(
                  pid,
                  content_visible
                )

                {:halt, socket}

              _event, _params, socket ->
                {:cont, socket}
            end)

          _ ->
            socket
        end
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
