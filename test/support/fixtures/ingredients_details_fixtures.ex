defmodule Bakery.IngredientsDetailsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bakery.IngredientsDetails` context.
  """

  @doc """
  Generate a ingredient_detail.
  """
  def ingredient_detail_fixture(attrs \\ %{}) do
    {:ok, ingredient_detail} =
      attrs
      |> Enum.into(%{
        price: "120.5"
      })
      |> Bakery.IngredientsDetails.create_ingredient_detail()

    ingredient_detail
  end
end
