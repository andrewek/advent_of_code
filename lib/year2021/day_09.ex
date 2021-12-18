defmodule AdventOfCode.Year2021.Day09 do
  @moduledoc """
  https://adventofcode.com/2021/day/9
  """

  def part_2(inputs) do
    lows = low_points(inputs)

    lows
    |> Enum.map(fn {point, _} ->
      point
      |> basin(inputs)
      |> MapSet.size()
    end)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  def basin(point, grid) do
    basin(MapSet.new(), point, grid)
  end

  def basin(set, {row, col} = point, grid) do
    if grid[point] in [9, nil] or point in set do
      set
    else
      set
      |> MapSet.put(point)
      |> basin({row - 1, col}, grid)
      |> basin({row + 1, col}, grid)
      |> basin({row, col - 1}, grid)
      |> basin({row, col + 1}, grid)
    end
  end

  # Return list of lowest items
  def part_1(inputs) do
    inputs
    |> low_points()
    |> Enum.map(fn({_, v}) -> v + 1 end)
    |> Enum.sum()
  end

  def low_points(inputs) do
    inputs
    |> Enum.filter(fn({{row, col}, height}) ->
      height < inputs[{row - 1, col}] and
      height < inputs[{row + 1, col}] and
      height < inputs[{row, col - 1}] and
      height < inputs[{row, col + 1}]
    end)
  end

  def collect_input() do
    lines =
      AdventOfCode.InputHelper.input_for(2021, 9)
      |> String.split("\n", trim: true)
      |> Enum.map(fn(line) -> String.split(line, "", trim: true) |> Enum.map(&String.to_integer/1) end)

    build_grid(lines)
  end

  # Why hello yes this is gross
  def build_grid(lines) do
    lines
    |> Enum.with_index(fn(row, row_index) ->
      {row_index, row}
    end)
    |> Enum.map(fn({row_index, row}) ->
      Enum.with_index(row, fn(col, col_index) ->
        %{value: col, row: row_index, col: col_index}
      end)
    end)
    |> List.flatten()
    |> Enum.reduce(%{}, fn(node, accumulator) ->
      Map.put(accumulator, {node.row, node.col}, node.value)
    end)
  end
end
