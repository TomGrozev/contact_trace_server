defmodule ContactTraceServer.Infections.Infection do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "infections" do
    field :first_name, :string
    field :last_name, :string

    field :used_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(infection, attrs) do
    infection
    |> cast(attrs, [:first_name, :last_name, :used_at])
    |> validate_required([:first_name, :last_name])
  end
end
