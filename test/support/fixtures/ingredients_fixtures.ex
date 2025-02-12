defmodule Bakery.IngredientsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bakery.Ingredients` context.
  """

  @doc """
  Generate a ingredient.
  """
  def ingredient_fixture(attrs \\ %{}) do
    {:ok, ingredient} =
      attrs
      |> Enum.into(%{
        name: "some name",
        price: "120.5"
      })
      |> Bakery.Ingredients.create_ingredient()

    ingredient
  end
end
