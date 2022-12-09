defmodule UserTracker.Repo.Migrations.TrackingSession do
  use Ecto.Migration

  def change do
    create table(:tracking_sessions) do
      add :browser_agent, :string
      add :unique_id, :text, null: false

      timestamps(updated_at: false)
    end
  end
end
