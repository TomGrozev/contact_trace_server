defmodule ContactTraceServerWeb.TraceController do
  use ContactTraceServerWeb, :controller

  alias ContactTraceServer.Trace

  def index(conn, _params) do
    contacts = Trace.list_contacts()

    json(conn, contacts)
  end

  def create(conn, %{"infection_code" => infection_code, "contacts" => contacts})
      when is_list(contacts) do
    Trace.create_contacts(infection_code, contacts)
    |> IO.inspect()
    |> case do
      {:ok, _contact_obj} ->
        json(conn, %{success: true})

      {:error, :invalid_infection_code} ->
        conn
        |> put_status(403)
        |> json(%{error: "invalid infection code"})

      {:error, _} ->
        conn
        |> put_status(400)
        |> json(%{error: "invalid request"})
    end
  end
end
