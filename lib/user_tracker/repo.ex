defmodule UserTracker.Repo do
  use Ecto.Repo,
    otp_app: :user_tracker,
    adapter: Ecto.Adapters.Postgres
end
