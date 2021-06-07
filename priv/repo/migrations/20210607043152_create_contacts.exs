defmodule ContactTraceServer.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add :expires_at, :utc_datetime
      add :contacts, :map

      timestamps()
    end
  end
end
