defmodule ContactTraceServer.Repo do
  use Ecto.Repo,
    otp_app: :contact_trace_server,
    adapter: Ecto.Adapters.Postgres
end
