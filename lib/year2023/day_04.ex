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
    parsed_inputs =
      inputs
      |> Enum.map(&parse_line/1)

    counter = build_counter(length(parsed_inputs))

    final_counter = process_inputs_pt_2(parsed_inputs, counter)
    IO.inspect(final_counter, label: "Final Counter")

    total_card_count(final_counter)
  end

  def process_inputs_pt_2([], counter) do
    counter
  end

  def process_inputs_pt_2([current_card | remaining_cards], counter) do
    %{
      card_number: current_index,
      match_count: match_count
    } = current_card

    new_counter = increment_count(counter, current_index, match_count)

    process_inputs_pt_2(remaining_cards, new_counter)
  end

  # If no matches, we add no cards
  def increment_count(counter, _, 0) do
    counter
  end

  def increment_count(counter, current_index, match_count) do
    card_count = counter[current_index]

    # If currently card 3 with 4 matches, we add to cards 4, 5, 6, and 7
    indices_to_increment = (current_index + 1)..(current_index + match_count)

    indices_to_increment
    |> Enum.reduce(counter, fn idx, accumulator ->
      current_count = accumulator[idx]
      new_count = current_count + card_count
      Map.put(accumulator, idx, new_count)
    end)
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

  defp put_score(input) do
    Map.put(input, :score, score(input))
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

  def score(%{match_count: 0}) do
    0
  end

  def score(%{match_count: count}) do
    2 ** (count - 1)
  end

  def build_counter(count) when count >= 1 do
    Enum.reduce(1..count, %{}, fn idx, accumulator ->
      Map.put(accumulator, idx, 1)
    end)
  end

  def total_card_count(counter) do
    counter
    |> Enum.reduce(0, fn {_, count}, sum -> sum + count end)
  end
end
