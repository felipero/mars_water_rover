defmodule WaterRover do
  @moduledoc """
  `WaterRover` is a module to process the mars rover water sensors to find water concentration in mars.
  """

  @doc """
  Process a string `input`, converts the elements to Integer and calls `process([count | [size | grid]])`.
  """
  def process(input) when is_binary(input),
    do:
      process(
        input
        |> String.split(" ")
        |> Enum.map(&(&1 |> String.trim() |> String.to_integer()))
      )

  @doc """
  Process the input and returns the resulting concentrations.

  The first position is the expected results `count`. The second is the `size` of the `grid`. The rest are the `grid`.

  ## Examples
      iex> WaterRover.process([3, 4, 2, 3, 2, 1, 4, 4, 2, 0, 3, 4, 1, 1, 2, 3, 4, 4])
      [
        [1, 2, %{score: 27}],
        [1, 1, %{score: 25}],
        [2, 2, %{score: 23}]
      ]
  """
  def process([count | [size | grid]]) do
    grid
    |> Enum.chunk_every(size)
    |> WaterRover.take_concentrations(count)
  end

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
    grid_array =
      grid
      |> Enum.map(&(:array.from_list(&1, 0) |> :array.fix()))
      |> :array.from_list([])

    for {cols, row} <- Enum.with_index(grid),
        {_, col} <- Enum.with_index(cols),
        into: Heap.new(&comparator/2) do
      [
        col,
        row,
        %{score: grid_array |> surroundings(row, col) |> Enum.sum()}
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

  defp surroundings(grid_array, row, col) do
    size = :array.size(grid_array)
    row_idx = if row - 1 < 0, do: size, else: row - 1
    col_idx = if col - 1 < 0, do: size, else: col - 1

    [
      grid_array |> get_elem(row_idx, col_idx, size),
      grid_array |> get_elem(row_idx, col, size),
      grid_array |> get_elem(row_idx, col + 1, size),
      grid_array |> get_elem(row, col_idx, size),
      grid_array |> get_elem(row, col, size),
      grid_array |> get_elem(row, col + 1, size),
      grid_array |> get_elem(row + 1, col_idx, size),
      grid_array |> get_elem(row + 1, col, size),
      grid_array |> get_elem(row + 1, col + 1, size)
    ]
  end

  defp get_elem(_, row, col, size) when row < 0 or col < 0 or row >= size or col >= size, do: 0

  defp get_elem(arr, row, col, _) do
    row_arr = :array.get(row, arr)
    :array.get(col, row_arr)
  end
end
