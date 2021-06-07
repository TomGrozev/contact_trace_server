defmodule ContactTraceServer.InfectionsTest do
  use ContactTraceServer.DataCase

  alias ContactTraceServer.Infections

  describe "infections" do
    alias ContactTraceServer.Infections.Infection

    @valid_attrs %{first_name: "some first_name", last_name: "some last_name"}
    @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name"}
    @invalid_attrs %{first_name: nil, last_name: nil}

    def infection_fixture(attrs \\ %{}) do
      {:ok, infection} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Infections.create_infection()

      infection
    end

    test "list_infections/0 returns all infections" do
      infection = infection_fixture()
      assert Infections.list_infections() == [infection]
    end

    test "get_infection!/1 returns the infection with given id" do
      infection = infection_fixture()
      assert Infections.get_infection!(infection.id) == infection
    end

    test "create_infection/1 with valid data creates a infection" do
      assert {:ok, %Infection{} = infection} = Infections.create_infection(@valid_attrs)
      assert infection.first_name == "some first_name"
      assert infection.last_name == "some last_name"
    end

    test "create_infection/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Infections.create_infection(@invalid_attrs)
    end

    test "update_infection/2 with valid data updates the infection" do
      infection = infection_fixture()
      assert {:ok, %Infection{} = infection} = Infections.update_infection(infection, @update_attrs)
      assert infection.first_name == "some updated first_name"
      assert infection.last_name == "some updated last_name"
    end

    test "update_infection/2 with invalid data returns error changeset" do
      infection = infection_fixture()
      assert {:error, %Ecto.Changeset{}} = Infections.update_infection(infection, @invalid_attrs)
      assert infection == Infections.get_infection!(infection.id)
    end

    test "delete_infection/1 deletes the infection" do
      infection = infection_fixture()
      assert {:ok, %Infection{}} = Infections.delete_infection(infection)
      assert_raise Ecto.NoResultsError, fn -> Infections.get_infection!(infection.id) end
    end

    test "change_infection/1 returns a infection changeset" do
      infection = infection_fixture()
      assert %Ecto.Changeset{} = Infections.change_infection(infection)
    end
  end
end
