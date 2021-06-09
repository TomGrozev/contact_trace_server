defmodule ContactTraceServer.Infections do
  @moduledoc """
  The Infections context.
  """

  import Ecto.Query, warn: false
  alias ContactTraceServer.Repo

  alias ContactTraceServer.Infections.Infection

  @doc """
  Returns the list of infections.

  ## Examples

      iex> list_infections()
      [%Infection{}, ...]

  """
  def list_infections do
    Repo.all(Infection)
  end

  @doc """
  Gets a single infection.

  Raises `Ecto.NoResultsError` if the Infection does not exist.

  ## Examples

      iex> get_infection!(123)
      %Infection{}

      iex> get_infection!(456)
      ** (Ecto.NoResultsError)

  """
  def get_infection!(id), do: Repo.get!(Infection, id)

  def use_infection_code(id) when is_binary(id) do
    case Repo.get(Infection, id) do
      nil ->
        {:error, :invalid_infection_code}

      %Infection{used_at: nil} = infection ->
        update_infection(infection, %{used_at: DateTime.utc_now()})

      %Infection{used_at: _} ->
        {:error, :invalid_infection_code}
    end
  end

  def use_infection_code(_id), do: {:error, :invalid_infection_code}

  @doc """
  Creates a infection.

  ## Examples

      iex> create_infection(%{field: value})
      {:ok, %Infection{}}

      iex> create_infection(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_infection(attrs \\ %{}) do
    %Infection{}
    |> Infection.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a infection.

  ## Examples

      iex> update_infection(infection, %{field: new_value})
      {:ok, %Infection{}}

      iex> update_infection(infection, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_infection(%Infection{} = infection, attrs) do
    infection
    |> Infection.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a infection.

  ## Examples

      iex> delete_infection(infection)
      {:ok, %Infection{}}

      iex> delete_infection(infection)
      {:error, %Ecto.Changeset{}}

  """
  def delete_infection(%Infection{} = infection) do
    Repo.delete(infection)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking infection changes.

  ## Examples

      iex> change_infection(infection)
      %Ecto.Changeset{data: %Infection{}}

  """
  def change_infection(%Infection{} = infection, attrs \\ %{}) do
    Infection.changeset(infection, attrs)
  end
end
