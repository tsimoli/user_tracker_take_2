defmodule UserTrackerWeb.Router do
  use UserTrackerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {UserTrackerWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :tracking do
    plug UserTrackerWeb.SessionTrackerPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", UserTrackerWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/", UserTrackerWeb do
    pipe_through :browser
    pipe_through :tracking

    live_session :tracked_pages,
      on_mount: [
        UserTrackerWeb.RandomTab,
        UserTrackerWeb.UserTracker
      ] do
      live "/page_a", PageALive
      live "/page_b", PageBLive
      live "/page_c", PageCLive, :index
      live "/page_c/tab_1", PageCLive, :tab1
      live "/page_c/tab_2", PageCLive, :tab2
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", UserTrackerWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:user_tracker, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: UserTrackerWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
