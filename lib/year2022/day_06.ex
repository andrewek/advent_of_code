defmodule AdventOfCode.Year2022.Day06 do
  @moduledoc """
  Year 2022 Day 6
  """
  def calc_part_1(inputs) do
    inputs
    |> marker_after()
  end

  def calc_part_2(inputs) do
    inputs
    |> message_after()
  end

  def marker_after(str) when is_binary(str) do
    chars = String.split(str, "", trim: true)

    marker_after(chars, 4)
  end

  def marker_after(chars, current_index) do
    substr = Enum.take(chars, 4)

    if unique_chars?(substr) do
      current_index
    else
      [_head | rest] = chars
      marker_after(rest, current_index + 1)
    end
  end

  def message_after(str) when is_binary(str) do
    chars = String.split(str, "", trim: true)

    message_after(chars, 14)
  end

  def message_after(chars, current_index) do
    substr = Enum.take(chars, 14)

    if unique_chars?(substr) do
      current_index
    else
      [_head | rest] = chars
      message_after(rest, current_index + 1)
    end
  end

  def collect_input() do
    AdventOfCode.InputHelper.input_for(2022, 6)
  end

  def unique_chars?(list) do
    Enum.uniq(list) == list
  end
end
