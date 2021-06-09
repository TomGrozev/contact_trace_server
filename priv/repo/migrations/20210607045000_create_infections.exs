defmodule ContactTraceServer.Repo.Migrations.CreateInfections do
  use Ecto.Migration

  def change do
    create table(:infections, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :first_name, :string
      add :last_name, :string

      timestamps()
    end
  end
end
