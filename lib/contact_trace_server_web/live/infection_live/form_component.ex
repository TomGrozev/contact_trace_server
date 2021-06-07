defmodule ContactTraceServerWeb.InfectionLive.FormComponent do
  use ContactTraceServerWeb, :live_component

  alias ContactTraceServer.Infections

  @impl true
  def update(%{infection: infection} = assigns, socket) do
    changeset = Infections.change_infection(infection)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"infection" => infection_params}, socket) do
    changeset =
      socket.assigns.infection
      |> Infections.change_infection(infection_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"infection" => infection_params}, socket) do
    save_infection(socket, socket.assigns.action, infection_params)
  end

  defp save_infection(socket, :edit, infection_params) do
    case Infections.update_infection(socket.assigns.infection, infection_params) do
      {:ok, _infection} ->
        {:noreply,
         socket
         |> put_flash(:info, "Infection updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_infection(socket, :new, infection_params) do
    case Infections.create_infection(infection_params) do
      {:ok, _infection} ->
        {:noreply,
         socket
         |> put_flash(:info, "Infection created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
