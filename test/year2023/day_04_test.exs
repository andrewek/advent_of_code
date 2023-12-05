defmodule AdventOfCode.Year2023.Day04Test do
  alias AdventOfCode.Year2023.Day04, as: Subject
  use ExUnit.Case, async: true

  describe "parse_and_score_line/1" do
    test "parses and scores a line with matches correctly" do
      input = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53"

      assert 8 == Subject.parse_and_score_line(input)
    end

    test "parses and scores a line with no matches correctly" do
      input = "Card           6:      31 18 13 56 72    |         74 77 10 23 35 67 36 11"

      assert 0 == Subject.parse_and_score_line(input)
    end
  end

  describe "parse_line/1" do
    test "parses correctly" do
      input = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53"

      assert %{
        raw_input: "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53",
        card_number: 1,
        winning_numbers: MapSet.new([41, 48, 83, 86, 17]),
        ticket_numbers: MapSet.new([83, 86, 6, 31, 17, 9, 48, 53]),
        intersection: MapSet.new([17, 48, 83, 86]),
        match_count: 4,
        score: 8
      } == Subject.parse_line(input)
    end
  end
end
