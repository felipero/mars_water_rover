defmodule WaterRoverTest do
  use ExUnit.Case
  doctest WaterRover

  @moduledoc false

  describe "take_concentrations/2" do

    test "returns the concentration for all locations in the grid, with index" do
      grid = [
        [5, 3, 1, 2],
        [4, 1, 1, 3],
        [2, 3, 2, 4],
        [0, 2, 3, 4]
      ]

      assert [
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
             ] == WaterRover.take_concentrations(grid)
    end

    test "returns the 3 biggest concentration in the grid, with index" do
      assert [
               [1, 2, %{score: 27}],
               [1, 1, %{score: 25}],
               [2, 2, %{score: 23}]
             ] ==
               WaterRover.take_concentrations(
                 [[2, 3, 2, 1], [4, 4, 2, 0], [3, 4, 1, 1], [2, 3, 4, 4]],
                 3
               )
    end

    test "returns empty for empty grid" do
      assert [] == WaterRover.take_concentrations([], 3)
    end

    test "returns empty for grid filled with empty rows" do
      assert [] == WaterRover.take_concentrations([[], []], 3)
    end
  end
end
