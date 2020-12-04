defmodule AdventOfCode.Year2020.Day02Test do
  alias AdventOfCode.Year2020.Day02, as: Subject
  use ExUnit.Case

  describe "parse_str/1" do
    test "parses" do
      str = "3-6 s: ssdsssss"

      expected = %{
        password: "ssdsssss",
        character: "s",
        min_count: 3,
        max_count: 6,
      }

      assert Subject.parse_str(str) == expected
    end
  end

  describe "calc_part_1/1" do
    test "counts good" do
      inputs = [
        %{
          password: "ssdsss",
          character: "s",
          min_count: 3,
          max_count: 6,
        },
      ]

      assert Subject.calc_part_1(inputs) == 1
    end

    test "counts bad" do
      inputs = [
        %{
          password: "ssdsss",
          character: "s",
          min_count: 1,
          max_count: 2,
        }
      ]

      assert Subject.calc_part_1(inputs) == 0
    end

    test "does it" do
      inputs = [
        %{
          password: "ssdsss",
          character: "s",
          min_count: 3,
          max_count: 6,
        },
        %{
          password: "ssdsss",
          character: "s",
          min_count: 1,
          max_count: 2,
        }
      ]

      assert Subject.calc_part_1(inputs) == 1
    end
  end

  describe "p1_valid_password?/1" do
    test "validates correctly" do
      pw = %{
        password: "ssdsss",
        character: "s",
        min_count: 3,
        max_count: 6,
      }

      assert Subject.p1_valid_password?(pw)
    end

    test "rejects correctly" do
      pw = %{
        password: "ssdsss",
        character: "s",
        min_count: 1,
        max_count: 2,
      }

      refute Subject.p1_valid_password?(pw)
    end
  end

  describe "p2_valid_password?/1" do
    test "accepts" do
      pw = %{
        password: "ssdsss",
        character: "s",
        min_count: 3,
        max_count: 6,
      }

      assert Subject.p2_valid_password?(pw)
    end

    test "rejects if both" do
      pw = %{
        password: "ssdsss",
        character: "s",
        min_count: 1,
        max_count: 2,
      }

      refute Subject.p2_valid_password?(pw)
    end

    test "rejects if neither" do
      pw = %{
        password: "ssdsss",
        character: "j",
        min_count: 3,
        max_count: 6,
      }

      refute Subject.p2_valid_password?(pw)
    end
  end
end
