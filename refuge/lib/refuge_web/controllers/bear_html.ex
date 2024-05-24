defmodule RefugeWeb.BearHTML do
  use RefugeWeb, :html

  embed_templates "bear_html/*"

  @doc """
  Renders a bear form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def bear_form(assigns)
end
