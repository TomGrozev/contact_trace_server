defmodule ContactTraceServerWeb.InfectionLive.Index do
  use ContactTraceServerWeb, :live_view

  alias ContactTraceServer.Infections
  alias ContactTraceServer.Infections.Infection

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :infections, list_infections())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Infection")
    |> assign(:infection, Infections.get_infection!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Infection")
    |> assign(:infection, %Infection{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Infections")
    |> assign(:infection, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    infection = Infections.get_infection!(id)
    {:ok, _} = Infections.delete_infection(infection)

    {:noreply, assign(socket, :infections, list_infections())}
  end

  defp list_infections do
    Infections.list_infections()
  end
end
