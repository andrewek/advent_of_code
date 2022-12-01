defmodule AdventOfCode.Year2021.Day01 do
  @moduledoc """
  https://adventofcode.com/2021/day/1
  """

  @doc """
  Count number of increases between an element and its successor
  """
  def part_1(inputs, counter) when length(inputs) >= 2 do
    [first, second | _rest] = inputs

    if first < second do
      part_1(tl(inputs), counter + 1)
    else
      part_1(tl(inputs), counter)
    end
  end

  def part_1(_inputs, counter) do
    counter
  end

  @doc """
  Count number of increases between elements 1-3 and elements 2-4 (sliding
  window), so 4 elements total
  """
  def part_2(inputs, counter) when length(inputs) >= 4 do
    [a, b, c, d | _rest] = inputs

    if a + b + c < b + c + d do
      part_2(tl(inputs), counter + 1)
    else
      part_2(tl(inputs), counter)
    end
  end

  def part_2(_inputs, counter) do
    counter
  end

  def collect_input() do
    AdventOfCode.InputHelper.input_for(2021, 1)
    |> String.split("\n")
    |> Enum.map(fn el -> String.to_integer(el) end)
  end
end
