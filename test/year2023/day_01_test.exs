defmodule AdventOfCode.Year2023.Day01Test do
  alias AdventOfCode.Year2023.Day01, as: Subject
  use ExUnit.Case, async: true

  describe "calibration_value/1" do
    test "calculates correctly" do
      assert 12 = Subject.calibration_value("1abc2")
      assert 38 = Subject.calibration_value("pqr3stu8vwx")
      assert 15 = Subject.calibration_value("a1b2c3d4e5f")
      assert 77 = Subject.calibration_value("treb7uchet")
    end
  end

  describe "calc_part_1/1" do
    test "works" do
      inputs = [
        "1abc2",
        "pqr3stu8vwx",
        "a1b2c3d4e5f",
        "treb7uchet"
      ]

      assert 142 = Subject.calc_part_1(inputs)
    end
  end

  describe "calc_part_2/1" do
    test "works" do
      inputs = [
        "two1nine",
        "eightwothree",
        "abcone2threexyz",
        "xtwone3four",
        "4nineeightseven2",
        "zoneight234",
        "7pqrstsixteen"
      ]

      assert 281 = Subject.calc_part_2(inputs)
    end
  end

  describe "full_calibration_value/1" do
    test "calculates correctly" do
      assert 29 = Subject.full_calibration_value("two1nine")
      assert 83 = Subject.full_calibration_value("eightwothree")
      assert 13 = Subject.full_calibration_value("abcone2threexyz")
      assert 24 = Subject.full_calibration_value("xtwone3four")
      assert 42 = Subject.full_calibration_value("4nineeightseven2")
      assert 14 = Subject.full_calibration_value("zoneight234")
      assert 76 = Subject.full_calibration_value("7pqrstsixteen")
      assert 61 = Subject.full_calibration_value("6one8sixninetwoner")
    end
  end
end
