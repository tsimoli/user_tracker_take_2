defmodule UserTrackerWeb.RandomTab do
  use UserTrackerWeb, :verified_routes
  alias UserTrackerWeb.PageCLive

  def on_mount(:default, _params, _session, socket) do
    case {socket.view, socket.assigns.live_action} do
      {PageCLive, :index} ->
        random = :rand.uniform(2)

        tab_path =
          case random do
            1 -> ~p"/page_c/tab_1"
            2 -> ~p"/page_c/tab_2"
          end

        {:halt, Phoenix.LiveView.redirect(socket, to: tab_path)}

      _ ->
        {:cont, socket}
    end
  end
end
