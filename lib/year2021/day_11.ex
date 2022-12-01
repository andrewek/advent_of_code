defmodule AdventOfCode.Year2021.Day11 do
  @moduledoc """
  https://adventofcode.com/2021/day/11
  """

  def part_1(inputs) do
    result =
      inputs
      |> part_1_step()

    result.flash_count
  end

  def part_2(inputs) do
    part_2_step(inputs, 0)
  end

  def part_2_step(%{grid: grid} = inputs, count) do
    if Enum.all?(grid, fn {_k, v} -> v.energy == 0 end) do
      count
    else
      inputs
      |> increment_all()
      |> flash_mob()
      |> count_and_clear_flashes()
      |> part_2_step(count + 1)
    end
  end

  # Increment each octopus, find out how many flashes we have, then keep going.
  def part_1_step(inputs, count \\ 0)

  def part_1_step(inputs, count) when count == 100 do
    inputs
  end

  # Do a regular step
  def part_1_step(inputs, count) do
    inputs
    |> increment_all()
    |> flash_mob()
    |> count_and_clear_flashes()
    |> part_1_step(count + 1)
  end

  def flash_mob(%{grid: grid} = inputs) do
    flashed_coords =
      grid
      |> Enum.filter(fn {_key, val} -> val.energy > 9 and !val.flashed end)

    if Enum.empty?(flashed_coords) do
      inputs
    else
      {coords, octopus} = hd(flashed_coords)
      adjacent = neighbors(coords)

      new_grid =
        grid
        |> Map.put(coords, %{energy: octopus.energy + 1, flashed: true})

      new_grid =
        adjacent
        |> Enum.reduce(new_grid, fn pos, acc ->
          tmp = new_grid[pos]
          Map.put(acc, pos, %{energy: tmp.energy + 1, flashed: tmp.flashed})
        end)

      %{inputs | grid: new_grid}
      |> flash_mob()
    end
  end

  def neighbors({row, col}) do
    [
      {row - 1, col},
      {row - 1, col - 1},
      {row - 1, col + 1},
      {row, col - 1},
      {row, col + 1},
      {row + 1, col},
      {row + 1, col - 1},
      {row + 1, col + 1}
    ]
    |> Enum.reject(fn {row, col} -> row < 0 or col < 0 or row > 9 or col > 9 end)
  end

  def increment_all(%{grid: grid} = inputs) do
    new_grid =
      grid
      |> Enum.map(fn {coords, octopus} ->
        {coords, %{energy: octopus.energy + 1, flashed: false}}
      end)
      |> Enum.into(%{})

    %{inputs | grid: new_grid}
  end

  # Get us ready for the next grid by clearing out flashes and updating the
  # flash count, per pt 1
  def count_and_clear_flashes(%{grid: grid, flash_count: count}) do
    new_count = Enum.count(grid, fn {_k, g} -> g.flashed end) + count

    new_grid =
      grid
      |> Enum.map(fn {coords, octopus} ->
        if octopus.flashed do
          {coords, %{energy: 0, flashed: false}}
        else
          {coords, octopus}
        end
      end)
      |> Enum.into(%{})

    %{
      grid: new_grid,
      flash_count: new_count
    }
  end

  # Transform 10x10 grid input into something a little easier to work with.
  def collect_input() do
    lines =
      AdventOfCode.InputHelper.input_for(2021, 11)
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        String.split(line, "", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)

    %{
      grid: build_grid(lines),
      flash_count: 0
    }
  end

  # Why hello yes this is gross
  def build_grid(lines) do
    lines
    |> Enum.with_index(fn row, row_index ->
      {row_index, row}
    end)
    |> Enum.map(fn {row_index, row} ->
      Enum.with_index(row, fn col, col_index ->
        %{value: col, row: row_index, col: col_index}
      end)
    end)
    |> List.flatten()
    |> Enum.reduce(%{}, fn node, accumulator ->
      Map.put(
        accumulator,
        {node.row, node.col},
        %{energy: node.value, flashed: false}
      )
    end)
  end
end
