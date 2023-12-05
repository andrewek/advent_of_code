defmodule AdventOfCode.Year2023.Day04 do
  @doc """
  https://adventofcode.com/2023/day/4
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
    AdventOfCode.InputHelper.input_for(2023, 4)
    |> String.split("\n", trim: true)
  end

  def calc_part_1(inputs) do
    inputs
    |> Enum.map(&parse_and_score_line/1)
    |> Enum.sum()
  end

  def calc_part_2(inputs) do
    inputs
  end

  def parse_and_score_line(line) do
    line
    |> parse_line()
    |> Map.get(:score)
  end

  def parse_line(line) do
    %{}
    |> Map.put(:raw_input, line)
    |> put_card_number()
    |> put_winning_numbers()
    |> put_ticket_numbers()
    |> put_intersection()
    |> put_score()
  end

  def score(%{match_count: 0}) do
    0
  end

  def score(%{match_count: count}) do
    2 ** (count - 1)
  end

  defp put_score(input) do
    Map.put(input, :score, score(input))
  end

  defp put_card_number(%{raw_input: line} = input) do
    [_, index] = Regex.run(~r/Card\s+(\d+)/, line)
    card_number = String.to_integer(index)

    Map.put(input, :card_number, card_number)
  end

  defp put_intersection(%{winning_numbers: winners, ticket_numbers: ticket} = input) do
    intersection = MapSet.intersection(winners, ticket)

    input
    |> Map.put(:intersection, intersection)
    |> Map.put(:match_count, MapSet.size(intersection))
  end

  defp put_ticket_numbers(%{raw_input: line} = input) do
    [_, ticket_str] = Regex.run(~r/\|\s+(.+)/, line, trim: true)

    ticket_numbers =
      ticket_str
      |> String.split(~r/\s+/, trim: true)
      |> Enum.map(&String.to_integer/1)
      |> MapSet.new()

    Map.put(input, :ticket_numbers, ticket_numbers)
  end

  defp put_winning_numbers(%{raw_input: line} = input) do
    [_, win_str] = Regex.run(~r/:\s*(.+)\s\|/, line, trim: true)

    winning_numbers =
      win_str
      |> String.split(~r/\s+/, trim: true)
      |> Enum.map(&String.to_integer/1)
      |> MapSet.new()

    Map.put(input, :winning_numbers, winning_numbers)
  end
end
