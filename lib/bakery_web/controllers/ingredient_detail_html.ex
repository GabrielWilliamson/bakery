defmodule BakeryWeb.IngredientDetailHTML do
  alias Bakery.Ingredients.Ingredient
  use BakeryWeb, :html

  embed_templates "ingredient_detail_html/*"

  @doc """
  Renders a ingredient_detail form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :units, :list, required: true
  attr :ingredient, Ingredient, required: true

  def ingredient_detail_form(assigns)
end
