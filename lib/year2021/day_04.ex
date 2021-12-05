defmodule AdventOfCode.Year2021.Day04 do
  @moduledoc """
  https://adventofcode.com/2021/day/4
  """

  ############# PART 1 #########################################

  def part_01(inputs) do
    %{
      moves: [current_move | remaining_moves],
      moves_completed: moves_completed,
      boards: boards
    } = inputs

    new_boards = Enum.map(boards, fn(b) -> apply_move(b, current_move, moves_completed) end)

    winner = Enum.find(new_boards, fn(b) -> score(b, current_move) > 0 end)

    if winner do
      {winner, score(winner, current_move)}
    else
      part_01(%{moves: remaining_moves, boards: new_boards, moves_completed: moves_completed + 1})
    end
  end

  def part_02(%{moves: moves, boards: boards} = inputs) when 0 == length(moves) do
    candidate_boards = Enum.filter(boards, fn(b) -> completed_board?(b) end)

    last_board =
      candidate_boards
      |> Enum.max_by(fn(b) -> b.completed_at end)

    {last_board, score(last_board, last_board.completed_with)}
  end

  def part_02(inputs) do
    %{
      moves: [current_move | remaining_moves],
      moves_completed: moves_completed,
      boards: boards
    } = inputs

    new_boards =
      boards
      |> Enum.map(fn(b) -> apply_move(b, current_move, moves_completed) end)

    part_02(%{
      moves: remaining_moves,
      boards: new_boards,
      moves_completed: moves_completed + 1
    })
  end

  def apply_move(%{cells: cells, completed_at: nil} = board, last_move, turn) do
    candidate_index = Enum.find_index(cells, fn({num, _val}) -> num == last_move end)

    if is_nil(candidate_index) do
      board
    else
      new_cells = List.replace_at(cells, candidate_index, {last_move, true})
      new_board = %{board | cells: new_cells}

      if completed_board?(new_board) do
        %{new_board | completed_at: turn, completed_with: last_move}
      else
        new_board
      end
    end
  end

  def apply_move(board, _last_move, _turn) do
    board
  end

  # Sum of all unmarked cells * winning number
  def score(board, last_move) do
    if completed_board?(board) do
      board.cells
      |> Enum.filter(fn {_number, value} -> value == false end)
      |> Enum.map(fn {number, _value} -> number end)
      |> Enum.sum()
      |> Kernel.*(last_move)
    else
      0
    end
  end

  def completed_board?(board) do
    cells = board.cells

    row_win?(cells) or col_win?(cells)
  end

  def row_win?(cells) do
    row_1_wins?(cells) or
    row_2_wins?(cells) or
    row_3_wins?(cells) or
    row_4_wins?(cells) or
    row_5_wins?(cells)
  end

  def col_win?(cells) do
    col_1_wins?(cells) or
    col_2_wins?(cells) or
    col_3_wins?(cells) or
    col_4_wins?(cells) or
    col_5_wins?(cells)
  end

  def row_1_wins?(cells) do
    [
      Enum.at(cells, 0),
      Enum.at(cells, 1),
      Enum.at(cells, 2),
      Enum.at(cells, 3),
      Enum.at(cells, 4)
    ]
    |> Enum.all?(fn {_any, matched} -> matched end)
  end

  def row_2_wins?(cells) do
    [
      Enum.at(cells, 5),
      Enum.at(cells, 6),
      Enum.at(cells, 7),
      Enum.at(cells, 8),
      Enum.at(cells, 9)
    ]
    |> Enum.all?(fn {_any, matched} -> matched end)
  end

  def row_3_wins?(cells) do
    [
      Enum.at(cells, 10),
      Enum.at(cells, 11),
      Enum.at(cells, 12),
      Enum.at(cells, 13),
      Enum.at(cells, 14)
    ]
    |> Enum.all?(fn {_any, matched} -> matched end)
  end

  def row_4_wins?(cells) do
    [
      Enum.at(cells, 15),
      Enum.at(cells, 16),
      Enum.at(cells, 17),
      Enum.at(cells, 18),
      Enum.at(cells, 19)
    ]
    |> Enum.all?(fn {_any, matched} -> matched end)
  end

  def row_5_wins?(cells) do
    [
      Enum.at(cells, 20),
      Enum.at(cells, 21),
      Enum.at(cells, 22),
      Enum.at(cells, 23),
      Enum.at(cells, 24)
    ]
    |> Enum.all?(fn {_any, matched} -> matched end)
  end

  def col_1_wins?(cells) do
    [
      Enum.at(cells, 0),
      Enum.at(cells, 5),
      Enum.at(cells, 10),
      Enum.at(cells, 15),
      Enum.at(cells, 20)
    ]
    |> Enum.all?(fn {_any, matched} -> matched end)
  end

  def col_2_wins?(cells) do
    [
      Enum.at(cells, 1),
      Enum.at(cells, 6),
      Enum.at(cells, 11),
      Enum.at(cells, 16),
      Enum.at(cells, 21)
    ]
    |> Enum.all?(fn {_any, matched} -> matched end)
  end

  def col_3_wins?(cells) do
    [
      Enum.at(cells, 2),
      Enum.at(cells, 7),
      Enum.at(cells, 12),
      Enum.at(cells, 17),
      Enum.at(cells, 22)
    ]
    |> Enum.all?(fn {_any, matched} -> matched end)
  end

  def col_4_wins?(cells) do
    [
      Enum.at(cells, 3),
      Enum.at(cells, 8),
      Enum.at(cells, 13),
      Enum.at(cells, 18),
      Enum.at(cells, 23)
    ]
    |> Enum.all?(fn {_any, matched} -> matched end)
  end

  def col_5_wins?(cells) do
    [
      Enum.at(cells, 4),
      Enum.at(cells, 9),
      Enum.at(cells, 14),
      Enum.at(cells, 19),
      Enum.at(cells, 24)
    ]
    |> Enum.all?(fn {_any, matched} -> matched end)
  end

  ############# PART 2 #########################################

  ############# INPUT COLLECTION ###############################

  def collect_input() do
    [moves | boards] =
      AdventOfCode.InputHelper.input_for(2021, 4)
      |> String.split("\n\n", trim: true)

    moves =
      moves
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer(&1))

    %{
      moves: moves,
      boards: cast_boards(boards),
      moves_completed: 0
    }
  end

  def cast_boards(els, accumulator \\ [])

  def cast_boards(els, accumulator) when length(els) == 0 do
    accumulator
  end

  def cast_boards([raw | rest], accumulator) do
    cells =
      raw
      |> String.split(~r/\s+/, trim: true)
      |> Enum.map(fn el -> {String.to_integer(el), false} end)

    board = %{
      index: length(accumulator) + 1,
      cells: cells,
      completed_at: nil,
      completed_with: nil
    }

    cast_boards(rest, [board | accumulator])
  end
end
