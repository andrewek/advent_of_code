defmodule AdventOfCode.Year2015.Day02 do
  @moduledoc """
  Day 02 of Year 2015
  """

  def calculate_paper(input) do
    input
    |> transform_input()
    |> Enum.map(&calculate_one_box/1)
    |> Enum.sum()
  end

  def calculate_ribbon(input) do
    input
    |> transform_input()
    |> Enum.map(&calculate_one_ribbon/1)
    |> Enum.sum()
  end

  @doc """
  Ribbon length = perimeter of smallest side plus volume of box
  """
  def calculate_one_ribbon({x, y, z}) do
    sides = [
      (x + x + y + y),
      (x + x + z + z),
      (y + y + z + z)
    ]

    [smallest | _] = Enum.sort(sides)
    bow_length = x * y * z
    smallest + bow_length
  end

  @doc """
  Given { x, y, z}, calculates lateral surface area + one more of the smallest side
  Returns integer
  """
  def calculate_one_box({x, y, z}) do
    sides = [
      (x * y),
      (x * z),
      (y * z),
    ]

    [smallest | _] = Enum.sort(sides)
    Enum.sum(sides) * 2 + smallest
  end

  @doc """
  Takes a string like "1x2x3\n2x3x4" and transforms it into:

  [{1, 2, 3}, {2, 3, 4}]
  """
  def transform_input(str) do
    str
    |> String.split("\n", trim: true)
    |> Enum.map(fn(str) ->
      [x, y, z] = String.split(str, "x")
      {
        String.to_integer(x),
        String.to_integer(y),
        String.to_integer(z)
      }
    end)
  end
end
