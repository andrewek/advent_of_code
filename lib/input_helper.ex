defmodule AdventOfCode.InputHelper do
  @moduledoc """
  Collects input from the right file
  """

  @doc """
  Year should be 2015, 2016, etc.
  Day should be 1, 2, 3, etc.
  Both should be simple numerics
  Returns a simple string, chomped of whitespace, with the puzzle input
  """
  def input_for(year, day) do
    {:ok, input} =
      constructed_file_name(year, day)
      |> File.read()

    String.trim_trailing(input)
  end

  defp constructed_file_name(year, day) do
    day_val =
      day
      |> Integer.to_string()
      |> String.pad_leading(2, "0")

    "puzzle_inputs/#{year}/day_#{day_val}.txt"
  end
end
