defmodule ContactTraceServer.Trace.Contact do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contact" do
    field :time, :utc_datetime
    field :uuid, :string

    belongs_to :contact_obj, ContactTraceServer.Trace.Contacts,
      foreign_key: :contact_id,
      references: :id,
      define_field: false

    timestamps()
  end

  @doc false
  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [:uuid, :time])
    |> validate_required([:uuid, :time])
  end
end
