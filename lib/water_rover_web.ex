defmodule WaterRoverWeb do
  @moduledoc """
    Plug web application to serve the json with water concentrations obtained from the mars water rover.
  """
  use Plug.Router

  plug(Plug.Logger, log: :debug)
  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  get "/" do
    %{"input" => input} = conn.params
    result = WaterRover.process(input)
    send_resp(conn, 200, Jason.encode!(result))
  end
end
