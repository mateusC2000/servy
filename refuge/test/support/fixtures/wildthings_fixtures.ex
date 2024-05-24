defmodule Refuge.WildthingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Refuge.Wildthings` context.
  """

  @doc """
  Generate a bear.
  """
  def bear_fixture(attrs \\ %{}) do
    {:ok, bear} =
      attrs
      |> Enum.into(%{
        hibernating: true,
        name: "some name",
        type: "some type"
      })
      |> Refuge.Wildthings.create_bear()

    bear
  end
end
