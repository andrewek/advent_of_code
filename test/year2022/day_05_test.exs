defmodule AdventOfCode.Year2022.Day05Test do
  use ExUnit.Case, async: true

  alias AdventOfCode.Year2022.Day05, as: Subject

  @test_input """
      [D]
  [N] [C]
  [Z] [M] [P]
   1   2   3

  move 1 from 2 to 1
  move 3 from 1 to 3
  move 2 from 2 to 1
  move 1 from 1 to 2
  """

  describe "calc_part_1/1" do
    test "works" do
      assert "CMZ" == Subject.calc_part_1(@test_input)
    end
  end

  describe "calc_part_2/1" do
    test "works" do
      assert "MCD" == Subject.calc_part_2(@test_input)
    end
  end

  describe "perform_move/2" do
    test "works" do
      move = %{count: 1, from: 2, to: 1}

      board = %{
        1 => ["N", "Z"],
        2 => ["D", "C", "M"],
        3 => ["P"]
      }

      next_board = Subject.perform_move(board, move)

      assert next_board == %{
               1 => ["D", "N", "Z"],
               2 => ["C", "M"],
               3 => ["P"]
             }
    end
  end

  describe "result_string/1" do
    test "works" do
      board = %{
        1 => ["N", "Z"],
        2 => ["D", "C", "M"],
        3 => ["P"]
      }

      assert "NDP" == Subject.result_string(%{board: board})
    end
  end

  describe "parse_input/1" do
    test "builds move list" do
      %{move_list: move_list} = Subject.parse_input(@test_input)

      assert move_list == [
               %{from: 2, to: 1, count: 1},
               %{from: 1, to: 3, count: 1},
               %{from: 1, to: 3, count: 1},
               %{from: 1, to: 3, count: 1},
               %{from: 2, to: 1, count: 1},
               %{from: 2, to: 1, count: 1},
               %{from: 1, to: 2, count: 1}
             ]
    end

    test "builds initial board state" do
      %{board: board} = Subject.parse_input(@test_input)

      assert board == %{
               1 => ["N", "Z"],
               2 => ["D", "C", "M"],
               3 => ["P"],
               4 => [],
               5 => [],
               6 => [],
               7 => [],
               8 => [],
               9 => []
             }
    end
  end

  describe "build_board/1" do
    test "builds as desired" do
      input = """
          [D]
      [N] [C]
      [Z] [M] [P]
       1   2   3
      """

      assert Subject.build_board(input) == %{
               1 => ["N", "Z"],
               2 => ["D", "C", "M"],
               3 => ["P"],
               4 => [],
               5 => [],
               6 => [],
               7 => [],
               8 => [],
               9 => []
             }
    end

    test "builds full input" do
      input = """
              [F] [Q]         [Q]
      [B]     [Q] [V] [D]     [S]
      [S] [P] [T] [R] [M]     [D]
      [J] [V] [W] [M] [F]     [J]     [J]
      [Z] [G] [S] [W] [N] [D] [R]     [T]
      [V] [M] [B] [G] [S] [C] [T] [V] [S]
      [D] [S] [L] [J] [L] [G] [G] [F] [R]
      [G] [Z] [C] [H] [C] [R] [H] [P] [D]
       1   2   3   4   5   6   7   8   9
      """

      assert Subject.build_board(input) == %{
               1 => ["B", "S", "J", "Z", "V", "D", "G"],
               2 => ["P", "V", "G", "M", "S", "Z"],
               3 => ["F", "Q", "T", "W", "S", "B", "L", "C"],
               4 => ["Q", "V", "R", "M", "W", "G", "J", "H"],
               5 => ["D", "M", "F", "N", "S", "L", "C"],
               6 => ["D", "C", "G", "R"],
               7 => ["Q", "S", "D", "J", "R", "T", "G", "H"],
               8 => ["V", "F", "P"],
               9 => ["J", "T", "S", "R", "D"]
             }
    end
  end

  describe "build_updated_move_list/1" do
  end

  describe "build_move_list/1" do
    test "works" do
      input = ["move 1 from 2 to 1", "move 2 from 5 to 7"]

      assert Subject.build_move_list(input) == [
               %{
                 from: 2,
                 to: 1,
                 count: 1
               },
               %{
                 from: 5,
                 to: 7,
                 count: 1
               },
               %{
                 from: 5,
                 to: 7,
                 count: 1
               }
             ]
    end
  end

  describe "transform_move/1" do
    test "transforms one move" do
      input = "move 1 from 2 to 1"

      assert Subject.transform_move(input) == [
               %{
                 from: 2,
                 count: 1,
                 to: 1
               }
             ]
    end

    test "transforms many moves" do
      input = "move 3 from 2 to 1"

      assert Subject.transform_move(input) == [
               %{
                 from: 2,
                 to: 1,
                 count: 1
               },
               %{
                 from: 2,
                 to: 1,
                 count: 1
               },
               %{
                 from: 2,
                 to: 1,
                 count: 1
               }
             ]
    end
  end
end
