defmodule UserTracker.Repo.Migrations.CreatePageviewTable do
  use Ecto.Migration

  def change do
    create table(:pageviews) do
      add :tracking_session_id, references(:tracking_sessions)
      add :module_name, :string
      add :additional_identity_information, :map, default: %{}
      add :engagement_time, :integer, default: 0

      timestamps()
    end
  end
end
