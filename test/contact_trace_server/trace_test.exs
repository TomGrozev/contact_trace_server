defmodule ContactTraceServer.TraceTest do
  use ContactTraceServer.DataCase

  alias ContactTraceServer.Trace

  describe "contact" do
    alias ContactTraceServer.Trace.Contact

    @valid_attrs %{time: "2010-04-17T14:00:00Z", uuid: "some uuid"}
    @update_attrs %{time: "2011-05-18T15:01:01Z", uuid: "some updated uuid"}
    @invalid_attrs %{time: nil, uuid: nil}

    def contact_fixture(attrs \\ %{}) do
      {:ok, contact} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Trace.create_contact()

      contact
    end

    test "list_contact/0 returns all contact" do
      contact = contact_fixture()
      assert Trace.list_contact() == [contact]
    end

    test "get_contact!/1 returns the contact with given id" do
      contact = contact_fixture()
      assert Trace.get_contact!(contact.id) == contact
    end

    test "create_contact/1 with valid data creates a contact" do
      assert {:ok, %Contact{} = contact} = Trace.create_contact(@valid_attrs)
      assert contact.time == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert contact.uuid == "some uuid"
    end

    test "create_contact/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trace.create_contact(@invalid_attrs)
    end

    test "update_contact/2 with valid data updates the contact" do
      contact = contact_fixture()
      assert {:ok, %Contact{} = contact} = Trace.update_contact(contact, @update_attrs)
      assert contact.time == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert contact.uuid == "some updated uuid"
    end

    test "update_contact/2 with invalid data returns error changeset" do
      contact = contact_fixture()
      assert {:error, %Ecto.Changeset{}} = Trace.update_contact(contact, @invalid_attrs)
      assert contact == Trace.get_contact!(contact.id)
    end

    test "delete_contact/1 deletes the contact" do
      contact = contact_fixture()
      assert {:ok, %Contact{}} = Trace.delete_contact(contact)
      assert_raise Ecto.NoResultsError, fn -> Trace.get_contact!(contact.id) end
    end

    test "change_contact/1 returns a contact changeset" do
      contact = contact_fixture()
      assert %Ecto.Changeset{} = Trace.change_contact(contact)
    end
  end

  describe "contacts" do
    alias ContactTraceServer.Trace.Contacts

    @valid_attrs %{expires_at: "2010-04-17T14:00:00Z"}
    @update_attrs %{expires_at: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{expires_at: nil}

    def contacts_fixture(attrs \\ %{}) do
      {:ok, contacts} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Trace.create_contacts()

      contacts
    end

    test "list_contacts/0 returns all contacts" do
      contacts = contacts_fixture()
      assert Trace.list_contacts() == [contacts]
    end

    test "get_contacts!/1 returns the contacts with given id" do
      contacts = contacts_fixture()
      assert Trace.get_contacts!(contacts.id) == contacts
    end

    test "create_contacts/1 with valid data creates a contacts" do
      assert {:ok, %Contacts{} = contacts} = Trace.create_contacts(@valid_attrs)
      assert contacts.expires_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_contacts/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trace.create_contacts(@invalid_attrs)
    end

    test "update_contacts/2 with valid data updates the contacts" do
      contacts = contacts_fixture()
      assert {:ok, %Contacts{} = contacts} = Trace.update_contacts(contacts, @update_attrs)
      assert contacts.expires_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_contacts/2 with invalid data returns error changeset" do
      contacts = contacts_fixture()
      assert {:error, %Ecto.Changeset{}} = Trace.update_contacts(contacts, @invalid_attrs)
      assert contacts == Trace.get_contacts!(contacts.id)
    end

    test "delete_contacts/1 deletes the contacts" do
      contacts = contacts_fixture()
      assert {:ok, %Contacts{}} = Trace.delete_contacts(contacts)
      assert_raise Ecto.NoResultsError, fn -> Trace.get_contacts!(contacts.id) end
    end

    test "change_contacts/1 returns a contacts changeset" do
      contacts = contacts_fixture()
      assert %Ecto.Changeset{} = Trace.change_contacts(contacts)
    end
  end
end
