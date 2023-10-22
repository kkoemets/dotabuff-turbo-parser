require Logger

defmodule ElixirWebScraping.Application do
  use Application

  def start(_type, _args) do
    Logger.info("Starting application")

    children = [
      Scheduler
    ]

    opts = [strategy: :one_for_one]
    Supervisor.start_link(children, opts)
  end
end
