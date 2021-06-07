defmodule ContactTraceServer.Repo.Migrations.CreateInfections do
  use Ecto.Migration

  def change do
    create table(:infections) do
      add :first_name, :string
      add :last_name, :string

      timestamps()
    end

  end
end