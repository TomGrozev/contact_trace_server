defmodule ContactTraceServer.Trace do
  @moduledoc """
  The Trace context.
  """

  import Ecto.Query, warn: false
  alias ContactTraceServer.Repo

  alias ContactTraceServer.Trace.Contact
  alias ContactTraceServer.Infections

  @doc """
  Creates a contact.

  ## Examples

      iex> create_contact(%{field: value})
      {:ok, %Contact{}}

      iex> create_contact(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_contact(attrs \\ %{}) do
    %Contact{}
    |> Contact.changeset(attrs)
    |> Repo.insert()
  end

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
    |> Contacts.changeset(%{expires_at: DateTime.utc_now(), contacts: contacts})
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
