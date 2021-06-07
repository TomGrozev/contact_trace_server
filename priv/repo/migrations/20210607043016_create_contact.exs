defmodule ContactTraceServer.Repo.Migrations.CreateContact do
  use Ecto.Migration

  def change do
    create table(:contact, primary_key: false) do
      add :uuid, :string
      add :time, :utc_datetime
      add :contact_id, references(:contacts, on_delete: :delete_all)

      timestamps()
    end
  end
end
