defmodule ContactTraceServer.Trace.Contacts do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contacts" do
    field :expires_at, :utc_datetime

    has_many :contacts, ContactTraceServer.Trace.Contact

    timestamps()
  end

  @doc false
  def changeset(contacts, attrs) do
    contacts
    |> cast(attrs, [:expires_at])
    |> validate_required([:expires_at])
  end
end
