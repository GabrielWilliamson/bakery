defmodule Bakery.Convertions do
  @moduledoc """
  The Convertions context.
  """

  import Ecto.Query, warn: false
  alias Bakery.Repo

  alias Bakery.Convertions.Convertion

  @doc """
  Returns the list of convertions.

  ## Examples

      iex> list_convertions()
      [%Convertion{}, ...]

  """
  def list_convertions do
    Repo.all(Convertion)
  end

  @doc """
  Gets a single convertion.

  Raises `Ecto.NoResultsError` if the Convertion does not exist.

  ## Examples

      iex> get_convertion!(123)
      %Convertion{}

      iex> get_convertion!(456)
      ** (Ecto.NoResultsError)

  """
  def get_convertion!(id), do: Repo.get!(Convertion, id)

  @doc """
  Creates a convertion.

  ## Examples

      iex> create_convertion(%{field: value})
      {:ok, %Convertion{}}

      iex> create_convertion(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_convertion(attrs \\ %{}) do
    %Convertion{}
    |> Convertion.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a convertion.

  ## Examples

      iex> update_convertion(convertion, %{field: new_value})
      {:ok, %Convertion{}}

      iex> update_convertion(convertion, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_convertion(%Convertion{} = convertion, attrs) do
    convertion
    |> Convertion.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a convertion.

  ## Examples

      iex> delete_convertion(convertion)
      {:ok, %Convertion{}}

      iex> delete_convertion(convertion)
      {:error, %Ecto.Changeset{}}

  """
  def delete_convertion(%Convertion{} = convertion) do
    Repo.delete(convertion)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking convertion changes.

  ## Examples

      iex> change_convertion(convertion)
      %Ecto.Changeset{data: %Convertion{}}

  """
  def change_convertion(%Convertion{} = convertion, attrs \\ %{}) do
    Convertion.changeset(convertion, attrs)
  end
end
