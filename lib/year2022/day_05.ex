defmodule AdventOfCode.Year2022.Day05 do
  @moduledoc """
  Year 2022 Day 5
  """
  @doc """
  Given inputs, determine what crates are on top of each stack
  """
  def calc_part_1(inputs) do
    inputs
    |> parse_input()
    |> process_moves()
    |> result_string()
  end

  def calc_part_2(inputs) do
    inputs
    |> parse_input_part_2()
    |> process_moves()
    |> result_string()
  end

  def collect_input() do
    AdventOfCode.InputHelper.input_for(2022, 5)
  end

  def process_moves(%{board: _board, move_list: []} = state) do
    state
  end

  def process_moves(%{board: board, move_list: [move | next_moves]}) do
    new_board = perform_move(board, move)

    process_moves(%{board: new_board, move_list: next_moves})
  end

  def perform_move(board, %{from: from_index, to: to_index, count: count} = _move) do
    {boxes, new_board} = remove_box_from_board(board, from_index, count)

    add_box_to_board(new_board, to_index, boxes)
  end

  def result_string(%{board: board}) do
    string =
      Enum.reduce(1..9, "", fn index, acc ->
        char = (board[index] || []) |> Enum.at(0) || ""
        acc <> char
      end)

    String.trim(string)
  end

  def parse_input(str) do
    [board, moves] = String.split(str, "\n\n", trim: true)

    move_list =
      moves
      |> String.split("\n", trim: true)
      |> build_move_list()

    board_map = build_board(board)

    %{
      board: board_map,
      move_list: move_list
    }
  end

  def parse_input_part_2(str) do
    [board, moves] = String.split(str, "\n\n", trim: true)

    move_list =
      moves
      |> String.split("\n", trim: true)
      |> build_move_list_part_2()

    board_map = build_board(board)

    %{
      board: board_map,
      move_list: move_list
    }
  end

  @doc """
  Build the board. This is a map where the key is the index and the value is a
  list, with the topmost box first

  Takes a string input, returns a map described above
  """
  def build_board(inputs) do
    inputs
    |> normalize_board_inputs()
  end

  def normalize_board_inputs(str) do
    [_header | lines] =
      str
      |> String.split("\n", trim: true)
      |> Enum.reverse()
      |> Enum.map(fn el -> String.split(el, "", trim: true) end)

    starting_board()
    |> process_board_lines(lines)
  end

  def process_board_lines(board, []) do
    board
  end

  def process_board_lines(board, [current_line | rest]) do
    new_board =
      Enum.reduce(1..9, board, fn index, accumulator ->
        str_pos = 4 * index - 3

        char = Enum.at(current_line, str_pos)

        add_box_to_board(accumulator, index, char)
      end)

    process_board_lines(new_board, rest)
  end

  def remove_box_from_board(board, index, count) do
    {popped, rest} = Enum.split(board[index], count)

    new_board = Map.put(board, index, rest)

    {popped, new_board}
  end

  def add_box_to_board(board, _index, "") do
    board
  end

  def add_box_to_board(board, _index, " ") do
    board
  end

  def add_box_to_board(board, _index, nil) do
    board
  end

  def add_box_to_board(board, index, box) when is_binary(box) do
    stack = board[index]

    Map.put(board, index, [box | stack])
  end

  def add_box_to_board(board, index, boxes) when is_list(boxes) do
    stack = board[index]

    Map.put(board, index, boxes ++ stack)
  end

  def starting_board() do
    %{1 => [], 2 => [], 3 => [], 4 => [], 5 => [], 6 => [], 7 => [], 8 => [], 9 => []}
  end

  @doc """
  Given the list of move strings, turn it into a useful list of moves
  """
  def build_move_list(inputs) do
    inputs
    |> Enum.map(&transform_move/1)
    |> List.flatten()
  end

  def build_move_list_part_2(inputs) do
    inputs
    |> Enum.map(&transform_move_part_2/1)
    |> List.flatten()
  end

  @doc """
  Given "move 3 from 5 to 7" or similar, create a list of 1 or more move tuples
  """
  def transform_move_part_2(str) do
    [[count], [from], [to]] = Regex.scan(~r/\d+/, str)

    [count, from, to]
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
    |> to_list_of_moves_part_2()
  end

  defp to_list_of_moves_part_2({count, from, to}) do
    %{count: count, from: from, to: to}
  end

  def transform_move(str) do
    [[count], [from], [to]] = Regex.scan(~r/\d+/, str)

    [count, from, to]
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
    |> to_list_of_moves()
  end

  defp to_list_of_moves({count, from, to}) do
    Enum.reduce(1..count, [], fn _el, acc ->
      [%{count: 1, from: from, to: to} | acc]
    end)
  end
end
