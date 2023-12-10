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

  describe "calc_part_2/1" do
    test "it works" do
      inputs = [
        "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53",
        "Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19",
        "Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1",
        "Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83",
        "Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36",
        "Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11"
      ]

      assert 30 == Subject.calc_part_2(inputs)
    end
  end

  describe "increment_counter/" do
    test "handles no matches" do
      input = %{
        1 => 1,
        2 => 1,
        3 => 1,
        4 => 1
      }

      assert input == Subject.increment_count(input, 1, 0)
      assert input == Subject.increment_count(input, 3, 0)
    end

    test "handles 1 match and 1 card" do
      input = %{
        1 => 1,
        2 => 1,
        3 => 1,
        4 => 1
      }

      # We have one of card one, and one match; now we need one extra of card 2
      assert %{input | 2 => 2} == Subject.increment_count(input, 1, 1)

      # We have one of card 3 and 1 match. Now we need 1 extra of card 4
      assert %{input | 4 => 2} == Subject.increment_count(input, 3, 1)
    end

    test "handles many matches and 1 card" do
      input = %{
        1 => 1,
        2 => 1,
        3 => 1,
        4 => 1
      }

      # 3 matches, so 1 extra of cards 2-4
      assert %{input | 2 => 2, 3 => 2, 4 => 2} == Subject.increment_count(input, 1, 3)
    end

    test "handles many cards and 1 match" do
      input = %{
        1 => 3,
        2 => 1,
        3 => 1,
        4 => 1
      }

      # 1 match on 3 cards, so 3 extra of card 2
      assert %{input | 2 => 4} == Subject.increment_count(input, 1, 1)
    end

    test "handles many matches and many cards" do
      input = %{
        1 => 3,
        2 => 1,
        3 => 1,
        4 => 1
      }

      # 3 matches on 3 cards, so 3 extra of cards 2-4
      assert %{input | 2 => 4, 3 => 4, 4 => 4} == Subject.increment_count(input, 1, 3)
    end
  end

  describe "build_counter/1" do
    test "it populates one item" do
      assert %{1 => 1} == Subject.build_counter(1)
    end

    test "it populates a bunch" do
      assert %{
               1 => 1,
               2 => 1,
               3 => 1,
               4 => 1
             } == Subject.build_counter(4)
    end
  end
end
