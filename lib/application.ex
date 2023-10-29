defmodule ElixirWebScraping.Application do
  use Application
  require Logger

  def start(_type, _args) do
    Logger.info("Starting application")

    children = [
      WebDriverProcess,
      Scheduler
    ]

    opts = [strategy: :one_for_one]
    Supervisor.start_link(children, opts)
  end
end
