defmodule AdventOfCode.Year2023.Day01 do
  @calibration_regex ~r/^(\d|one|two|three|four|five|six|seven|eight|nine|ten)/
  @numerics %{
    "1" => 1,
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5,
    "6" => 6,
    "7" => 7,
    "8" => 8,
    "9" => 9,
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5,
    "six" => 6,
    "seven" => 7,
    "eight" => 8,
    "nine" => 9
  }

  @doc """
  Part 1:

  Determine the "calibration value" as determined by the two digit number
  created by the first digit and last digit in a string.

  Then add all the calibration values together.

  Part 2:

  https://adventofcode.com/2023/day/1
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
    AdventOfCode.InputHelper.input_for(2023, 1)
    |> String.split("\n", trim: true)
  end

  # Sum the "calibration values"
  def calc_part_1(inputs) do
    inputs
    |> Enum.map(&calibration_value/1)
    |> Enum.sum()
  end

  def calc_part_2(inputs) do
    inputs
    |> Enum.map(&full_calibration_value/1)
    |> Enum.sum()
  end

  def calibration_value(line) do
    line
    |> String.split("")
    |> Enum.filter(fn el -> String.match?(el, ~r/\d/) end)
    |> crunch_list_into_number()
  end

  def full_calibration_value(line) do
    full_calibration_value([], line)
  end

  # End once the line to process is empty
  def full_calibration_value(list, "") do
    list
    |> crunch_list_into_number()
  end

  # See if the line starts with a valid numeric, and if so, take it, then
  # slice off the first character of the line and keep going.
  def full_calibration_value(list, line) do
    new_list =
      if String.match?(line, @calibration_regex) do
        list ++ Regex.run(@calibration_regex, line, capture: :first)
      else
        list
      end

    {_, next_line} = String.split_at(line, 1)

    full_calibration_value(new_list, next_line)
  end

  def crunch_list_into_number(numbers) do
    first_digit = List.first(numbers)
    last_digit = List.last(numbers)

    convert_to_numeric(first_digit, last_digit)
  end

  def convert_to_numeric(first_digit_str, second_digit_str) do
    first_digit = @numerics[first_digit_str]
    second_digit = @numerics[second_digit_str]

    10 * first_digit + second_digit
  end
end
