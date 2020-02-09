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
    send_resp(conn, 200, "Hi")
  end
end
