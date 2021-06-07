defmodule ContactTraceServer.Trace.Contact do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :time, :utc_datetime
    field :uuid, :string
  end

  @doc false
  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [:uuid, :time])
    |> validate_required([:uuid, :time])
  end
end
