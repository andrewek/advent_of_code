defmodule AdventOfCode.Year2021.Day05 do
  @moduledoc """
  https://adventofcode.com/2021/day/5
  """

  @doc """
  Counting just horizontal and vertical lines, count intersections
  """
  def part_1(inputs) do
    # Get only horizontal and vertical lines
    filtered_inputs =
      inputs
      |> Enum.filter(fn %{start: {x1, y1}, finish: {x2, y2}} -> x1 == x2 or y1 == y2 end)

    filtered_inputs
    |> Enum.map(&draw_line/1)
    |> List.flatten()
    |> Enum.frequencies()
    |> Enum.count(fn {_k, v} -> v > 1 end)
  end

  def part_2(inputs) do
    inputs
    |> Enum.map(&draw_line/1)
    |> List.flatten()
    |> Enum.frequencies()
    |> Enum.count(fn {_k, v} -> v > 1 end)
  end

  # Vertical line
  def draw_line(%{start: {x1, y1}, finish: {x2, y2}}) when x1 == x2 do
    y1..y2
    |> Enum.map(fn y -> {x1, y} end)
  end

  # Horizonal line
  def draw_line(%{start: {x1, y1}, finish: {x2, y2}}) when y1 == y2 do
    x1..x2
    |> Enum.map(fn x -> {x, y1} end)
  end

  # Diagonal
  def draw_line(%{start: {x1, y1}, finish: {x2, y2}}) do
    x_vals = x1..x2
    y_vals = y1..y2

    Enum.zip(x_vals, y_vals)
  end

  def collect_input() do
    AdventOfCode.InputHelper.input_for(2021, 5)
    |> String.split("\n")
    |> Enum.map(&get_coords(&1))
  end

  # "123,345 -> 789,120" --> %{start: {123, 345}, finish: {789, 120}}
  defp get_coords(str) do
    [start, finish] = String.split(str, " -> ", trim: true)

    start_coords = str_to_coords(start)

    finish_coords = str_to_coords(finish)

    %{start: start_coords, finish: finish_coords}
  end

  # "123,345" -> {123, 345}
  defp str_to_coords(str) do
    str
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer(&1))
    |> List.to_tuple()
  end
end
