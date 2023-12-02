defmodule AdventOfCode.Year2023.Day02 do
  @doc """
  https://adventofcode.com/2023/day/2
  """
  def full_part_1() do
    collect_input()
    |> calc_part_1()
  end

  def full_part_2() do
    collect_input()
    |> calc_part_2()
  end

  def collect_input() do
    AdventOfCode.InputHelper.input_for(2023, 2)
    |> String.split("\n", trim: true)
  end

  # Determine the sum of the game numbers that are possible with:
  # 12 red cubes, 13 green cubes, and 14 blue cubes
  def calc_part_1(inputs, desired_move \\ %{red: 12, green: 13, blue: 14}) do
    inputs
    |> parse_lines()
    |> game_indices_against(desired_move)
    |> Enum.sum()
  end

  def calc_part_2(inputs) do
    inputs
    |> calculate_power_for_lines()
    |> Enum.sum()
  end

  def calculate_power_for_lines(lines) do
    lines
    |> Enum.map(fn line -> parse_line(line) |> calculate_power() end)
  end

  def calculate_power({_, %{max_red: red, max_blue: blue, max_green: green}}) do
    red * blue * green
  end

  def game_indices_against(lines, %{red: red, green: green, blue: blue}) do
    Enum.reduce(lines, [], fn {index, data}, indices ->
      if data[:max_red] <= red && data[:max_blue] <= blue && data[:max_green] <= green do
        [index | indices]
      else
        indices
      end
    end)
  end

  def parse_lines(all_lines) do
    all_lines
    |> Enum.map(&parse_line/1)
    |> Enum.into(%{})
  end

  def parse_line(line) do
    index = game_index(line)

    [_, relevant_line] = String.split(line, ":", trim: true)

    moves = transform_moves(relevant_line)

    data =
      %{moves: moves}
      |> Map.merge(calculate_maxima(moves))

    {index, data}
  end

  # Given a semi-colon separated set of moves, transform into a list of maps
  # representing each move
  def transform_moves(moves) do
    moves
    |> String.split(";", trim: true)
    |> Enum.map(&transform_one_move/1)
  end

  # Given a single "red 3, green 7" (etc.) string, transform
  def transform_one_move(move) do
    %{
      red: extract_move(move, "red"),
      blue: extract_move(move, "blue"),
      green: extract_move(move, "green")
    }
  end

  # Given a list of moves as produced by transform_moves, determine max shown of
  # each color
  def calculate_maxima(moves) do
    %{
      max_red: calculate_maximum_of_color(moves, :red),
      max_blue: calculate_maximum_of_color(moves, :blue),
      max_green: calculate_maximum_of_color(moves, :green)
    }
  end

  # For a given color (represented as atom), determine the max count for that
  # color
  defp calculate_maximum_of_color(moves, color) do
    moves
    |> Enum.max_by(fn el -> el[color] end)
    |> Map.get(color)
  end

  defp color_count(nil) do
    0
  end

  defp color_count([_, count_str]) do
    String.to_integer(count_str)
  end

  defp extract_move(move, color) do
    Regex.compile!("(\\d+) #{color}")
    |> Regex.run(move)
    |> color_count()
  end

  defp game_index(line) do
    [_, index] = Regex.run(~r/Game (\d+)/, line)
    String.to_integer(index)
  end
end
