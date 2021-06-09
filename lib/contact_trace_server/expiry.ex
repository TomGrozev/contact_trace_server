defmodule ContactTraceServer.Expiry do
  use GenServer

  require Logger

  alias ContactTraceServer.Trace

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_expire_check()
    {:ok, state}
  end

  def handle_info(:check_expired, state) do
    # Removes any expired contacts
    Logger.info("Running trace expiry check")

    Trace.remove_expired_contacts()

    schedule_expire_check()
    {:noreply, state}
  end

  defp schedule_expire_check() do
    Process.send_after(self(), :check_expired, 5 * 60 * 1000) # In 5 minutes
  end
end
