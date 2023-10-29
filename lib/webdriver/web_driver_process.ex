defmodule WebDriverProcess do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    start_webdriver()
    {:ok, nil}
  end

  defp start_webdriver do
    System.cmd("chromedriver", [])
  end
end
