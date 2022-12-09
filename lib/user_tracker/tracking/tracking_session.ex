defmodule UserTracker.TrackingSession.TrackingSession do
  use Ecto.Schema

  alias UserTracker.TrackingSession.TrackingSession

  schema "tracking_sessions" do
    field :unique_id, :binary
    field :browser_agent, :string

    timestamps(updated_at: false)
  end

  def build_tracking_session(browser_agent) do
    unique_id = Ecto.UUID.generate()
    {unique_id, %TrackingSession{unique_id: unique_id, browser_agent: browser_agent}}
  end
end
