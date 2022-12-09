defmodule UserTracker.TrackingSession.Pageview do
  use Ecto.Schema

  import Ecto.Changeset

  schema "pageviews" do
    belongs_to :tracking_session, UserTracker.TrackingSession.TrackingSession
    field :module_name, :string
    field :additional_identity_information, :map
    field :engagement_time, :integer

    timestamps()
  end

  def changeset(pageview, attrs) do
    pageview
    |> cast(attrs, [
      :tracking_session_id,
      :module_name,
      :additional_identity_information,
      :engagement_time
    ])
  end
end
