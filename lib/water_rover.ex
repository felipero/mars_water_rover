defmodule WaterRover do
  @moduledoc """
  `WaterRover` is a module to process the mars rover water sensors to find water concentration in mars.
  """

  @doc """
  Returns a list containing the `count` biggest concentrations in the `grid` with the index in the format [x, y, score: sum].
  @doc """
  Returns a list containing the concentrations in the `grid` with the index, ordered by the biggest concentrations.
  The return will be in the format [x, y, score: sum].

  ## Examples
      iex> grid = [[5, 3, 1, 2], [4, 1, 1, 3], [2, 3, 2, 4], [0, 2, 3, 4]]
      iex> WaterRover.take_concentrations(grid)
      [
        [2, 2, %{score: 23}],
        [1, 1, %{score: 22}],
        [2, 1, %{score: 20}],
        [0, 1, %{score: 18}],
        [1, 2, %{score: 18}],
        [2, 3, %{score: 18}],
        [3, 2, %{score: 17}],
        [1, 0, %{score: 15}],
        [0, 0, %{score: 13}],
        [3, 1, %{score: 13}],
        [3, 3, %{score: 13}],
        [0, 2, %{score: 12}],
        [1, 3, %{score: 12}],
        [2, 0, %{score: 11}],
        [0, 3, %{score: 7}],
        [3, 0, %{score: 7}]
      ]
  """
  def take_concentrations(grid = [[_ | _] | _]) do
    for {cols, row} <- Enum.with_index(grid),
        {_, col} <- Enum.with_index(cols),
        into: Heap.new(&comparator/2) do
      [
        col,
        row,
        %{score: grid |> surroundings(row, col) |> Enum.sum()}
      ]
    end
    |> Enum.to_list()
  end

  @doc """
  Returns a list containing the `count` biggest concentrations in the `grid` with the index in the format [x, y, score: sum].

  ## Examples
      iex> grid = [[5, 3, 1, 2], [4, 1, 1, 3], [2, 3, 2, 4], [0, 2, 3, 4]]
      iex> WaterRover.take_concentrations(grid, 3)
      [
        [2, 2, %{score: 23}],
        [1, 1, %{score: 22}],
        [1, 2, %{score: 20}]
      ]
  """
  def take_concentrations(grid = [[_ | _] | _], count),
    do: take_concentrations(grid) |> Enum.take(count)

  @doc """
  Returns an empty list when the grid is empty or filled with empty lists.
  """
  def take_concentrations(_, _), do: []

  defp comparator(first, second),
    do:
      {Enum.at(first, 2), -Enum.at(first, 0), -Enum.at(first, 1)} >=
        {Enum.at(second, 2), -Enum.at(second, 0), -Enum.at(second, 1)}

  defp surroundings(grid, row, col) do
    size = Enum.count(grid)
    left_idx = if row - 1 < 0, do: size, else: row - 1
    top_idx = if col - 1 < 0, do: size, else: col - 1

    [
      grid |> Enum.at(left_idx, []) |> Enum.at(top_idx, 0),
      grid |> Enum.at(left_idx, []) |> Enum.at(col, 0),
      grid |> Enum.at(left_idx, []) |> Enum.at(col + 1, 0),
      grid |> Enum.at(row, []) |> Enum.at(top_idx, 0),
      grid |> Enum.at(row, []) |> Enum.at(col, 0),
      grid |> Enum.at(row, []) |> Enum.at(col + 1, 0),
      grid |> Enum.at(row + 1, []) |> Enum.at(top_idx, 0),
      grid |> Enum.at(row + 1, []) |> Enum.at(col, 0),
      grid |> Enum.at(row + 1, []) |> Enum.at(col + 1, 0)
    ]
  end
end
