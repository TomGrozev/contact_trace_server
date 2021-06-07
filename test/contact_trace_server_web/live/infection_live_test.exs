defmodule ContactTraceServerWeb.InfectionLiveTest do
  use ContactTraceServerWeb.ConnCase

  import Phoenix.LiveViewTest

  alias ContactTraceServer.Infections

  @create_attrs %{first_name: "some first_name", last_name: "some last_name"}
  @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name"}
  @invalid_attrs %{first_name: nil, last_name: nil}

  defp fixture(:infection) do
    {:ok, infection} = Infections.create_infection(@create_attrs)
    infection
  end

  defp create_infection(_) do
    infection = fixture(:infection)
    %{infection: infection}
  end

  describe "Index" do
    setup [:create_infection]

    test "lists all infections", %{conn: conn, infection: infection} do
      {:ok, _index_live, html} = live(conn, Routes.infection_index_path(conn, :index))

      assert html =~ "Listing Infections"
      assert html =~ infection.first_name
    end

    test "saves new infection", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.infection_index_path(conn, :index))

      assert index_live |> element("a", "New Infection") |> render_click() =~
               "New Infection"

      assert_patch(index_live, Routes.infection_index_path(conn, :new))

      assert index_live
             |> form("#infection-form", infection: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#infection-form", infection: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.infection_index_path(conn, :index))

      assert html =~ "Infection created successfully"
      assert html =~ "some first_name"
    end

    test "updates infection in listing", %{conn: conn, infection: infection} do
      {:ok, index_live, _html} = live(conn, Routes.infection_index_path(conn, :index))

      assert index_live |> element("#infection-#{infection.id} a", "Edit") |> render_click() =~
               "Edit Infection"

      assert_patch(index_live, Routes.infection_index_path(conn, :edit, infection))

      assert index_live
             |> form("#infection-form", infection: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#infection-form", infection: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.infection_index_path(conn, :index))

      assert html =~ "Infection updated successfully"
      assert html =~ "some updated first_name"
    end

    test "deletes infection in listing", %{conn: conn, infection: infection} do
      {:ok, index_live, _html} = live(conn, Routes.infection_index_path(conn, :index))

      assert index_live |> element("#infection-#{infection.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#infection-#{infection.id}")
    end
  end

  describe "Show" do
    setup [:create_infection]

    test "displays infection", %{conn: conn, infection: infection} do
      {:ok, _show_live, html} = live(conn, Routes.infection_show_path(conn, :show, infection))

      assert html =~ "Show Infection"
      assert html =~ infection.first_name
    end

    test "updates infection within modal", %{conn: conn, infection: infection} do
      {:ok, show_live, _html} = live(conn, Routes.infection_show_path(conn, :show, infection))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Infection"

      assert_patch(show_live, Routes.infection_show_path(conn, :edit, infection))

      assert show_live
             |> form("#infection-form", infection: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#infection-form", infection: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.infection_show_path(conn, :show, infection))

      assert html =~ "Infection updated successfully"
      assert html =~ "some updated first_name"
    end
  end
end
