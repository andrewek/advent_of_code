defmodule AdventOfCode.Year2021.Day10 do
  @moduledoc """
  https://adventofcode.com/2021/day/10
  """

  def part_2(inputs) do
    scores =
      inputs
      |> process_lines()
      |> Enum.filter(fn(l) -> l.valid and length(l.opening_tags) > 0 end)
      |> Enum.map(&score_line/1)
      |> Enum.sort()

    scores
  end

  def score_line(line) do
    # Recall that opening tags are in reverse order already - this is a stack,
    # basically
    %{opening_tags: tags} = line

    tags
    |> Enum.map(&p2_score/1)
    |> Enum.reduce(0, fn(val, acc) ->
      IO.inspect({acc, val, acc * 5 + val}, label: "The Score")
      acc * 5 + val
    end)
  end

  def p2_score(char) do
    case char do
      "(" -> 1
      "[" -> 2
      "{" -> 3
      "<" -> 4
    end
  end

  def process_lines(inputs) do
    inputs
    |> Enum.map(&process_line/1)
  end

  def part_1(inputs) do
    inputs
    |> process_lines()
    |> Enum.filter(fn(a) -> !a.valid end)
    |> Enum.map(fn(a) -> a.bad_character |> p1_score() end)
    |> Enum.sum()
  end

  def p1_score(char) do
    case char do
      ")" -> 3
      "]" -> 57
      "}" -> 1197
      ">" -> 25137
    end
  end

  def process_line(line) when is_list(line) do
    %{
      remaining_chars: line,
      valid: true,
      opening_tags: []
    }
    |> process_line()
  end

  # Exit cond
  def process_line(%{remaining_chars: chrs} = input) when length(chrs) == 0 do
    input
  end

  def process_line(input) do
    %{
      remaining_chars: [current_char | remaining_chars],
      opening_tags: tags
    } = input

    if current_char in ["(", "<", "[", "{"] do
      tags = [current_char | tags]

      %{
        remaining_chars: remaining_chars,
        valid: true,
        opening_tags: tags
      }
      |> process_line()
    else
      [last_tag | other_tags] = tags

      # We have the rigth closing tag for a recently opened tag
      if last_tag == expected_tag_for(current_char) do
        %{
          remaining_chars: remaining_chars,
          valid: true,
          opening_tags: other_tags
        }
        |> process_line()
      else
        # We have an error!
        %{
          valid: false,
          remaining_chars: remaining_chars,
          opening_tags: tags,
          bad_character: current_char
        }
      end
    end
  end

  # Given a closing tag, get the expected opening tag
  def expected_tag_for(tag) do
    case tag do
      "}" -> "{"
      ")" -> "("
      ">" -> "<"
      "]" -> "["
    end
  end

  def collect_input() do
    AdventOfCode.InputHelper.input_for(2021, 10)
    |> String.split("\n")
    |> Enum.map(fn el -> String.split(el, "", trim: true) end)
  end
end
