defmodule ContactTraceServer.Infections.Infection do
  use Ecto.Schema
  import Ecto.Changeset

  schema "infections" do
    field :first_name, :string
    field :last_name, :string

    timestamps()
  end

  @doc false
  def changeset(infection, attrs) do
    infection
    |> cast(attrs, [:first_name, :last_name])
    |> validate_required([:first_name, :last_name])
  end
end
