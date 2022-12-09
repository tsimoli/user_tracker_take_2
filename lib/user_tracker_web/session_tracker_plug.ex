defmodule UserTrackerWeb.SessionTrackerPlug do
  import Plug.Conn

  alias UserTracker.Tracking

  # 300 days
  @max_age 60 * 60 * 24 * 300

  def init(options), do: options

  def call(conn, _opts) do
    case get_session(conn, "unique_id") do
      nil ->
        browser_agent = get_req_header(conn, "user-agent")
        unique_id = Tracking.create_tracking_session(hd(browser_agent))

        put_resp_cookie(conn, "unique_id", unique_id, max_age: @max_age)
        |> put_session(:unique_id, unique_id)

      _ ->
        conn
    end
  end
end
