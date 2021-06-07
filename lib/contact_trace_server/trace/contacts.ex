defmodule ContactTraceServer.Trace.Contacts do
  use Ecto.Schema
  import Ecto.Changeset

  alias ContactTraceServer.Trace.Contact

  schema "contacts" do
    field :expires_at, :utc_datetime

    embeds_many :contacts, Contact

    timestamps()
  end

  @doc false
  def changeset(contacts, attrs) do
    contacts
    |> cast(attrs, [:expires_at])
    |> cast_embed(:contacts, with: &Contact.changeset/2)
    |> validate_required([:expires_at])
  end
end
