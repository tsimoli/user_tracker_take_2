defmodule UserTracker.UserEngagementTracker do
  use GenServer

  alias UserTracker.Tracking

  @second 1000

  # Client

  def start_link(initial_state) do
    GenServer.start_link(
      __MODULE__,
      initial_state
    )
  end

  def change_content_visibility(pid, content_visible) do
    GenServer.cast(pid, {:content_visible, content_visible})
  end

  # Server

  @impl true
  def init([unique_id, view]) do
    {:ok, %{unique_id: unique_id, view: view}, {:continue, :create_page_view}}
  end

  @impl true
  def handle_continue(:create_page_view, %{unique_id: unique_id, view: view}) do
    tracking_session = Tracking.get_tracking_session_by_unique_id(unique_id)

    pageview =
      Tracking.create_pageview(%{
        tracking_session_id: tracking_session.id,
        module_name: Atom.to_string(view),
        additional_information: %{}
      })

    tracking_data = %{
      pageview_id: pageview.id,
      engagement_time: 1,
      content_visible: false
    }

    Process.send_after(self(), :tick, @second)
    {:noreply, tracking_data}
  end

  @impl true
  def handle_cast({:content_visible, content_visible}, tracking_data) do
    {:noreply, %{tracking_data | content_visible: content_visible}}
  end

  @impl true
  def handle_info(
        :tick,
        %{
          pageview_id: pageview_id,
          engagement_time: engagement_time,
          content_visible: content_visible
        } = tracking_data
      ) do
    engagement_time =
      if content_visible do
        new_engagement_time = engagement_time + 1
        Tracking.update_pageview(pageview_id, %{engagement_time: new_engagement_time})
        new_engagement_time
      else
        engagement_time
      end

    Process.send_after(self(), :tick, @second)

    {:noreply, %{tracking_data | engagement_time: engagement_time}}
  end
end
