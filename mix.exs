defmodule WaterRover.MixProject do
  use Mix.Project

  def project do
    [
      app: :mars_water_rover,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {WaterRover.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.2.2", only: [:dev]},
      {:heap, "~> 2.0"},
      {:jason, "~> 1.1"},
      {:plug_cowboy, "~> 2.0"}
    ]
  end
end
