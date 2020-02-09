defmodule WaterRoverTest do
  use ExUnit.Case
  doctest WaterRover

  @moduledoc false

  describe "take_concentrations/2" do
    @grid [
      [5, 3, 1, 2],
      [4, 1, 1, 3],
      [2, 3, 2, 4],
      [0, 2, 3, 4]
    ]

    test "returns the concentration for all locations in the grid, with index" do
      assert [
               [2, 2, score: 23],
               [1, 1, score: 22],
               [1, 2, score: 20],
               [1, 0, score: 18],
               [2, 1, score: 18],
               [3, 2, score: 18],
               [2, 3, score: 17],
               [0, 1, score: 15],
               [0, 0, score: 13],
               [1, 3, score: 13],
               [3, 3, score: 13],
               [2, 0, score: 12],
               [3, 1, score: 12],
               [0, 2, score: 11],
               [0, 3, score: 7],
               [3, 0, score: 7]
             ] == WaterRover.take_concentrations(@grid, 16)
    end

    test "returns the 3 biggest concentration in the grid, with index" do
      assert [
               [2, 2, score: 23],
               [1, 1, score: 22],
               [1, 2, score: 20]
             ] == WaterRover.take_concentrations(@grid, 3)
    end
end
