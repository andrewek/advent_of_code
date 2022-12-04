defmodule AdventOfCode.Year2022.Day04Test do
  alias AdventOfCode.Year2022.Day04, as: Subject
  use ExUnit.Case

  @inputs [
    "2-4,6-8",
    "2-3,4-5",
    "5-7,7-9",
    "2-8,3-7",
    "6-6,4-6",
    "2-6,4-8"
  ]

  describe "calc_part_1/1" do
    test "counts overlaps" do
      assert 2 == Subject.calc_part_1(@inputs)
    end
  end

  describe "calc_part_2/1" do
    test "counts partial and full overlaps" do
      assert 4 == Subject.calc_part_2(@inputs)
    end
  end

  describe "fully_overlapping_assignment?/2" do
    test "no overlap" do
      input = {MapSet.new(1..2), MapSet.new(5..7)}

      refute Subject.fully_overlapping_assignment?(input)
    end

    test "partial overlap" do
      input = {MapSet.new(1..5), MapSet.new(3..8)}
      refute Subject.fully_overlapping_assignment?(input)
    end

    test "full overlap - a inside b" do
      input = {MapSet.new(1..5), MapSet.new(1..8)}
      assert Subject.fully_overlapping_assignment?(input)
    end

    test "full overlap - b inside a" do
      input = {MapSet.new(1..5), MapSet.new(3..4)}
      assert Subject.fully_overlapping_assignment?(input)
    end
  end

  describe "partially_overlapping_assignment?/2" do
    test "no overlap" do
      input = {MapSet.new(1..2), MapSet.new(5..7)}

      refute Subject.partially_overlapping_assignment?(input)
    end

    test "partial overlap" do
      input = {MapSet.new(1..5), MapSet.new(3..8)}
      assert Subject.partially_overlapping_assignment?(input)
    end

    test "full overlap - a inside b" do
      input = {MapSet.new(1..5), MapSet.new(1..8)}
      assert Subject.partially_overlapping_assignment?(input)
    end

    test "full overlap - b inside a" do
      input = {MapSet.new(1..5), MapSet.new(3..4)}
      assert Subject.partially_overlapping_assignment?(input)
    end
  end

  describe "parse_line/1" do
    test "parses" do
      [line | _] = @inputs

      desired_result = {
        MapSet.new([2, 3, 4]),
        MapSet.new([6, 7, 8])
      }

      assert ^desired_result = Subject.parse_line(line)
    end
  end
end
