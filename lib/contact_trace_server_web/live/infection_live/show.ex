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

  defp page_title(:show), do: "Show Infection"
  defp page_title(:edit), do: "Edit Infection"
end
