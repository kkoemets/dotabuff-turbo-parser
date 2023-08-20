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
    columns = get_columns(map_row)
    parse_datetime(columns)
  end

  @doc false
  def get_columns(map_row) do
    Logger.info("Finding columns")
    Floki.find(map_row, "td")
  end

  @doc false
  def parse_datetime(columns) do
    Logger.info("Parsing datetime")
    time_element = Floki.find(Enum.at(columns, 0), "time")

    Enum.at(Floki.attribute(time_element, "datetime"), 0)
  end

  @doc false
  def parse_result(columns) do
    Logger.info("Parsing result")
    result_element = Floki.find(Enum.at(columns, 2), "a")

    Floki.text(result_element)
  end

  @doc false
  def parse_radiant_team(columns) do
    Logger.info("Parsing radiant team")
    radiant_team_elements = Floki.find(Enum.at(columns, 4), "div a")

    Enum.map(radiant_team_elements, fn element ->
      case Floki.attribute(element, "href") do
        [href | _] -> List.last(String.split(href, "/"))
        [] -> nil
      end
    end)
  end

  @doc false
  def parse_dire_team(columns) do
    Logger.info("Parsing dire team")
    dire_team_elements = Floki.find(Enum.at(columns, 5), "div a")

    Enum.map(dire_team_elements, fn element ->
      case Floki.attribute(element, "href") do
        [href | _] -> List.last(String.split(href, "/"))
        [] -> nil
      end
    end)
  end

  @doc false
  def remove_first_element(list) do
    List.delete(list, Enum.at(list, 0))
  end
end
