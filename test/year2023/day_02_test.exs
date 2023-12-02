defmodule AdventOfCode.Year2023.Day02Test do
  alias AdventOfCode.Year2023.Day02, as: Subject
  use ExUnit.Case, async: true

  describe "calc_part_2/1" do
    test "calculates one line" do
      inputs = ["Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"]

      assert 48 = Subject.calc_part_2(inputs)
    end

    test "calculates many lines" do
      inputs = [
        "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
        "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue",
        "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red",
        "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red",
        "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"
      ]

      assert 2286 = Subject.calc_part_2(inputs)
    end
  end

  describe "calc_part_1/2" do
    test "filters appropriately when within parameters" do
      input = ["Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"]

      assert 1 = Subject.calc_part_1(input)
    end

    test "can be overridden" do
      input = ["Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"]

      assert 0 = Subject.calc_part_1(input, %{red: 1, blue: 2, green: 3})
    end

    test "works for multiple lines" do
      input = [
        "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
        "Game 2: 93 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
        "Game 3: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
      ]

      assert 4 = Subject.calc_part_1(input)
    end
  end

  describe "parse_lines/1" do
    test "parses correctly with one line" do
      input = ["Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"]

      desired_output = %{
        1 => %{
          moves: [
            %{red: 4, blue: 3, green: 0},
            %{red: 1, blue: 6, green: 2},
            %{red: 0, blue: 0, green: 2}
          ],
          max_red: 4,
          max_blue: 6,
          max_green: 2
        }
      }

      assert ^desired_output = Subject.parse_lines(input)
    end

    test "with many lines" do
      input = [
        "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
        "Game 2: 1 blue",
        "Game 3: 2 red; 1 blue"
      ]

      desired_output = %{
        1 => %{
          moves: [
            %{red: 4, blue: 3, green: 0},
            %{red: 1, blue: 6, green: 2},
            %{red: 0, blue: 0, green: 2}
          ],
          max_red: 4,
          max_blue: 6,
          max_green: 2
        },
        2 => %{
          moves: [%{red: 0, blue: 1, green: 0}],
          max_red: 0,
          max_blue: 1,
          max_green: 0
        },
        3 => %{
          moves: [%{red: 2, blue: 0, green: 0}, %{red: 0, blue: 1, green: 0}],
          max_red: 2,
          max_blue: 1,
          max_green: 0
        }
      }

      assert ^desired_output = Subject.parse_lines(input)
    end
  end

  describe "parse_line/1" do
    test "parses correctly" do
      input = "Game 7: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"

      desired_data = %{
        moves: [
          %{red: 4, blue: 3, green: 0},
          %{red: 1, blue: 6, green: 2},
          %{red: 0, blue: 0, green: 2}
        ],
        max_red: 4,
        max_blue: 6,
        max_green: 2
      }

      assert {7, ^desired_data} = Subject.parse_line(input)
    end
  end

  describe "calculate_maxima/1" do
    test "calculates correctly" do
      moves = [
        %{red: 2, blue: 0, green: 0},
        %{red: 0, blue: 3, green: 2},
        %{red: 3, blue: 1, green: 0}
      ]

      desired_output = %{max_red: 3, max_blue: 3, max_green: 2}

      assert ^desired_output = Subject.calculate_maxima(moves)
    end
  end

  describe "transform_moves/1" do
    test "calculates correctly" do
      moves = "2 red; 3 blue, 2 green; 3 red, 1 blue"

      desired_output = [
        %{red: 2, blue: 0, green: 0},
        %{red: 0, blue: 3, green: 2},
        %{red: 3, blue: 1, green: 0}
      ]

      assert ^desired_output = Subject.transform_moves(moves)
    end
  end

  describe "transform_one_move/1" do
    test "with empty string" do
      assert %{red: 0, blue: 0, green: 0} = Subject.transform_one_move("")
    end

    test "with red" do
      assert %{red: 7, blue: 0, green: 0} = Subject.transform_one_move("7 red")
    end

    test "with all colors" do
      assert %{red: 7, blue: 23, green: 99} =
               Subject.transform_one_move("99 green, 7 red, 23 blue")
    end
  end
end
