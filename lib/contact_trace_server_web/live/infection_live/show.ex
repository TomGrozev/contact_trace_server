defmodule ContactTraceServerWeb.InfectionLive.Show do
  use ContactTraceServerWeb, :live_view

  alias ContactTraceServer.Infections

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:infection, Infections.get_infection!(id))}
  end

  @impl true
  def handle_event("reset_usage", _params, socket) do
    case Infections.reset_usage(socket.assigns.infection) do
      {:ok, infection} ->
        {:noreply,
         socket
         |> put_flash(:info, "Infection usage cleared")
         |> assign(:infection, infection)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply,
         socket
         |> put_flash(:error, "Failed to reset usage of infection code")}
    end
  end

  defp page_title(:show), do: "Show Infection"
  defp page_title(:edit), do: "Edit Infection"
end
