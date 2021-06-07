defmodule ContactTraceServer.Repo.Migrations.AddUsedField do
  use Ecto.Migration

  def change do
    alter table(:infections) do
      add :used_at, :utc_datetime
    end
  end
end
