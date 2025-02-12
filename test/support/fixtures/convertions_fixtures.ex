defmodule Bakery.ConvertionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bakery.Convertions` context.
  """

  @doc """
  Generate a convertion.
  """
  def convertion_fixture(attrs \\ %{}) do
    {:ok, convertion} =
      attrs
      |> Enum.into(%{
        conversion_factor: "120.5"
      })
      |> Bakery.Convertions.create_convertion()

    convertion
  end
end
