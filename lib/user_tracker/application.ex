defmodule UserTracker.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      UserTrackerWeb.Telemetry,
      # Start the Ecto repository
      UserTracker.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: UserTracker.PubSub},
      # Start Finch
      {Finch, name: UserTracker.Finch},
      # Start the Endpoint (http/https)
      UserTrackerWeb.Endpoint,
      {DynamicSupervisor, strategy: :one_for_one, name: UserTracker.DynamicSupervisor},
      {Registry, keys: :unique, name: UserEngagementTrackerRegistry}

      # Start a worker by calling: UserTracker.Worker.start_link(arg)
      # {UserTracker.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: UserTracker.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    UserTrackerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
