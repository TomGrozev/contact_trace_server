defmodule ContactTraceServer.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add :expires_at, :utc_datetime

      timestamps()
    end
  end
end
