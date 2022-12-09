defmodule UserTracker.Tracking do
  alias UserTracker.Repo
  alias UserTracker.TrackingSession.{TrackingSession, Pageview}

  def create_tracking_session(browser_agent) do
    {unique_id, tracking_session} = TrackingSession.build_tracking_session(browser_agent)
    Repo.insert!(tracking_session)
    unique_id
  end

  def get_tracking_session_by_unique_id(id) do
    Repo.get_by(TrackingSession, unique_id: id)
  end

  def create_pageview(attrs) do
    Pageview.changeset(%Pageview{}, attrs)
    |> Repo.insert!()
  end

  def update_pageview(id, attrs) do
    case Repo.get(Pageview, id) do
      nil ->
        {:error, "Pageview not found with id"}

      pageview ->
        Pageview.changeset(pageview, attrs)
        |> Repo.update()
    end
  end
end
