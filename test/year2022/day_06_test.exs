defmodule AdventOfCode.Year2022.Day06Test do
  alias AdventOfCode.Year2022.Day06, as: Subject
  use ExUnit.Case

  describe "calc_part_1/1" do
  end

  describe "calc_part_2/1" do
  end

  describe "marker_after/1" do
    test "cases" do
      assert Subject.marker_after("bvwbjplbgvbhsrlpgdmjqwftvncz") == 5
      assert Subject.marker_after("nppdvjthqldpwncqszvftbrmjlhg") == 6
      assert Subject.marker_after("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 10
      assert Subject.marker_after("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 11
    end
  end

  describe "message_after/1" do
    test "cases" do
      assert Subject.message_after("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 19
      assert Subject.message_after("bvwbjplbgvbhsrlpgdmjqwftvncz") == 23
      assert Subject.message_after("nppdvjthqldpwncqszvftbrmjlhg") == 23
      assert Subject.message_after("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 29
      assert Subject.message_after("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 26
    end
  end

  describe "unique_chars?/1" do
    test "unique" do
      assert Subject.unique_chars?(["a", "b", "c", "d"])
    end

    test "not unique" do
      refute Subject.unique_chars?(["a", "b", "c", "a"])
    end
  end
end
