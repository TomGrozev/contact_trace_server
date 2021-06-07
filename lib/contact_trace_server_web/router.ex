defmodule ContactTraceServerWeb.Router do
  use ContactTraceServerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ContactTraceServerWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ContactTraceServerWeb do
    pipe_through :browser

    live "/", PageLive, :index

    live "/infections", InfectionLive.Index, :index
    live "/infections/new", InfectionLive.Index, :new
    live "/infections/:id/edit", InfectionLive.Index, :edit

    live "/infections/:id", InfectionLive.Show, :show
    live "/infections/:id/show/edit", InfectionLive.Show, :edit
  end

  scope "/api", ContactTraceServerWeb do
    pipe_through :api

    get "/", TraceController, :index
    post "/trace", TraceController, :create
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ContactTraceServerWeb.Telemetry
    end
  end
end
