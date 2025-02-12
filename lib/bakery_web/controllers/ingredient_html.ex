defmodule BakeryWeb.IngredientHTML do
  use BakeryWeb, :html

  embed_templates "ingredient_html/*"

  @doc """
  Renders a ingredient form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :units, :list, required: true
  attr :details, :list


  def ingredient_form(assigns)
end
