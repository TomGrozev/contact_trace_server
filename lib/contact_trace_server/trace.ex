defmodule ContactTraceServer.Trace do
  @moduledoc """
  The Trace context.
  """

  require Logger

  import Ecto.Query, warn: false
  alias ContactTraceServer.Repo

  alias ContactTraceServer.Trace.Contact
  alias ContactTraceServer.Infections

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking contact changes.

  ## Examples

      iex> change_contact(contact)
      %Ecto.Changeset{data: %Contact{}}

  """
  def change_contact(%Contact{} = contact, attrs \\ %{}) do
    Contact.changeset(contact, attrs)
  end

  alias ContactTraceServer.Trace.Contacts

  @doc """
  Returns the list of contacts.

  ## Examples

      iex> list_contacts()
      [%Contacts{}, ...]

  """
  def list_contacts do
    Repo.all(Contacts)
  end

  @doc """
  Returns the list of contacts.

  ## Examples

      iex> list_contacts()
      [%Contacts{}, ...]

  """
  def list_public_contacts do
    Repo.all(from c in Contacts, select: c.contacts)
    |> Enum.map(fn c -> Enum.map(c, &%{uuid: &1.uuid, time: &1.time}) end)
  end

  @doc """
  Gets a single contacts.

  Raises `Ecto.NoResultsError` if the Contacts does not exist.

  ## Examples

      iex> get_contacts!(123)
      %Contacts{}

      iex> get_contacts!(456)
      ** (Ecto.NoResultsError)

  """
  def get_contacts!(id), do: Repo.get!(Contacts, id)

  @doc """
  Creates a contacts.

  ## Examples

      iex> create_contacts(%{field: value})
      {:ok, %Contacts{}}

      iex> create_contacts(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_contacts(infection_code, contacts) do
    Infections.use_infection_code(infection_code)
    |> case do
      {:ok, _infection} ->
        do_create_contacts(contacts)

      any ->
        any
    end
  end

  defp do_create_contacts(contacts) do
    %Contacts{}
    |> Contacts.changeset(%{
      expires_at: DateTime.add(DateTime.utc_now(), 2 * 7 * 24 * 60 * 60, :second),
      contacts: contacts
    })
    |> Repo.insert()
  end

  @doc """
  Updates a contacts.

  ## Examples

      iex> update_contacts(contacts, %{field: new_value})
      {:ok, %Contacts{}}

      iex> update_contacts(contacts, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_contacts(%Contacts{} = contacts, attrs) do
    contacts
    |> Contacts.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Removes all expired contacts
  """
  def remove_expired_contacts() do
    {removed, _} =
      res = Repo.delete_all(from c in Contacts, where: c.expires_at < ^DateTime.utc_now())

    Logger.debug("Removed #{removed} item#{if removed > 1, do: 's', else: ''}")

    res
  end

  @doc """
  Deletes a contacts.

  ## Examples

      iex> delete_contacts(contacts)
      {:ok, %Contacts{}}

      iex> delete_contacts(contacts)
      {:error, %Ecto.Changeset{}}

  """
  def delete_contacts(%Contacts{} = contacts) do
    Repo.delete(contacts)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking contacts changes.

  ## Examples

      iex> change_contacts(contacts)
      %Ecto.Changeset{data: %Contacts{}}

  """
  def change_contacts(%Contacts{} = contacts, attrs \\ %{}) do
    Contacts.changeset(contacts, attrs)
  end
end
