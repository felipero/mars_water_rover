defmodule WaterRover do
  @moduledoc """
  `WaterRover` is a module to process the mars rover water sensors to find water concentration in mars.
  """

  @doc """
  Returns a list containing the `count` biggest concentrations in the `grid` with the index in the format [x, y, score: sum].

  ## Examples
      iex> grid = [[5, 3, 1, 2], [4, 1, 1, 3], [2, 3, 2, 4], [0, 2, 3, 4]]
      iex> WaterRover.take_concentrations(grid, 3)
      [
        [2, 2, score: 23],
        [1, 1, score: 22],
        [1, 2, score: 20]
      ]
  """
  def take_concentrations(grid, count) do
    comparator = &({Enum.at(&1, 2), -Enum.at(&1, 0)} >= {Enum.at(&2, 2), -Enum.at(&2, 0)})

    for {row, row_idx} <- Enum.with_index(grid),
        {_, col} <- Enum.with_index(row),
        into: Heap.new(comparator) do
      # into: Heap.new(&comparator/2) do

      [
        row_idx,
        col,
        score: grid |> surroundings(row_idx, col) |> Enum.sum()
      ]
    end
    |> Enum.take(count)
  end
  defp surroundings(grid, row, col) do
    size = Enum.count(grid)
    left_idx = if row - 1 < 0, do: size, else: row - 1
    top_idx = if col - 1 < 0, do: size, else: col - 1

    [
      grid |> Enum.at(left_idx, []) |> Enum.at(top_idx, 0),
      grid |> Enum.at(row, []) |> Enum.at(top_idx, 0),
      grid |> Enum.at(row + 1, []) |> Enum.at(top_idx, 0),
      grid |> Enum.at(left_idx, []) |> Enum.at(col, 0),
      grid |> Enum.at(row, []) |> Enum.at(col, 0),
      grid |> Enum.at(row + 1, []) |> Enum.at(col, 0),
      grid |> Enum.at(left_idx, []) |> Enum.at(col + 1, 0),
      grid |> Enum.at(row, []) |> Enum.at(col + 1, 0),
      grid |> Enum.at(row + 1, []) |> Enum.at(col + 1, 0)
    ]
  end
end
