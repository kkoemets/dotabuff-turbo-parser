defmodule DotabuffClient do
  require Logger

  @doc false
  def get_html() do
    Logger.info("Getting HTML")

    case HTTPoison.get("https://www.dotabuff.com/matches?game_mode=turbo") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        {:error, "Received status code #{status_code}"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  @doc false
  def get_table(html) do
    Logger.info("Getting table")
    {:ok, document} = Floki.parse_document(html)
    Floki.raw_html(Floki.find(document, "table"))
  end

  @doc false
  def get_rows(html_table) do
    Logger.info("Finding rows")
    {:ok, document} = Floki.parse_document(html_table)
    Floki.raw_html(Floki.find(document, "tr"))
  end

  @doc false
  def create_data(html_rows) do
    Logger.info("Creating data")
    {:ok, document} = Floki.parse_document(html_rows)
    rows = remove_first_element(Floki.find(document, "tr"))
    row = Enum.at(rows, 0)
    parse_row(row)
  end

  @doc false
  def parse_row(map_row) do
    Logger.info("Parsing row")
    columns = Floki.find(map_row, "td")
    parse_column(Enum.at(columns, 0))
  end

  @doc false
  def parse_column(column) do
    Logger.info("Parsing column")
    Logger.info(inspect(column))
  end

  defp remove_first_element(list) do
    List.delete(list, Enum.at(list, 0))
  end
end
