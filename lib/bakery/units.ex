defmodule Bakery.Units do
  @moduledoc """
  The Units context.
  """

  import Ecto.Query, warn: false
  alias Bakery.Repo

  alias Bakery.Units.Unit

  @doc """
  Returns the list of units.

  ## Examples

      iex> list_units()
      [%Unit{}, ...]

  """
  def list_units(tenant) do
    Repo.all(Unit, prefix: Triplex.to_prefix(tenant))
  end

  def list_units_base(tenant) do
    query =
      from u in Unit,
        select: %{id: u.id, label: u.name}

    Repo.all(query, prefix: Triplex.to_prefix(tenant))
  end
end
