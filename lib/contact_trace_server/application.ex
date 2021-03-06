defmodule ContactTraceServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ContactTraceServer.Repo,
      # Start the Telemetry supervisor
      ContactTraceServerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ContactTraceServer.PubSub},
      # Start the Endpoint (http/https)
      ContactTraceServerWeb.Endpoint,
      # Start a worker by calling: ContactTraceServer.Worker.start_link(arg)
      # {ContactTraceServer.Worker, arg}
      ContactTraceServer.Expiry
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ContactTraceServer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ContactTraceServerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
