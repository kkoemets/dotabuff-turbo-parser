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

    case Floki.parse_document(html) do
      {:ok, document} ->
        Floki.find(document, "table")
        |> Floki.raw_html()
    end
  end

  @doc false
  def get_rows(html_table) do
    Logger.info("Finding rows")

    case Floki.parse_document(html_table) do
      {:ok, document} ->
        Floki.find(document, "tr")
        |> Floki.raw_html()
    end
  end

  @doc false
  def create_data(html_rows) do
    Logger.info("Creating data")

    case Floki.parse_document(html_rows) do
      {:ok, document} ->
          remove_first_element(Floki.find(document, "tr"))
          |> Enum.at(0)
          |> parse_row()
    end
  end

  @spec parse_row(
          binary
          | [
              binary
              | {:comment, binary}
              | {:pi | binary, binary | [{any, any}], list}
              | {:doctype, binary, binary, binary}
            ]
        ) :: any
  @doc false
  def parse_row(map_row) do
    Logger.info("Parsing row")

    map_row
    |> get_columns()
    |> parse_datetime()
  end

  @doc false
  def get_columns(map_row) do
    Logger.info("Finding columns")

    map_row
    |> Floki.find("td")
  end

  @doc false
  def parse_match_id(columns) do
    Logger.info("Parsing match id")

    columns
    |> Enum.at(0)
    |> Floki.find("a")
    |> Floki.attribute("href")
    |> hd()
    |> String.split("/")
    |> List.last()
  end

  @doc false
  def parse_datetime(columns) do
    Logger.info("Parsing datetime")

    columns
    |> Enum.at(0)
    |> Floki.find("time")
    |> Floki.attribute("datetime")
    |> hd()
    |> String.split("/")
    |> List.last()
  end

  @spec parse_result(any) :: binary
  @doc false
  def parse_result(columns) do
    Logger.info("Parsing result")

    columns
    |> Enum.at(2)
    |> Floki.find("a")
    |> Floki.text()
  end

  @doc false
  def parse_radiant_team(columns) do
    Logger.info("Parsing radiant team")

    columns
    |> Enum.at(4)
    |> Floki.find("div a")
    |> Enum.map(fn element ->
      case Floki.attribute(element, "href") do
        [href | _] -> List.last(String.split(href, "/"))
        [] -> nil
      end
    end)
  end

  @doc false
  def parse_dire_team(columns) do
    Logger.info("Parsing dire team")

    columns
    |> Enum.at(5)
    |> Floki.find("div a")
    |> Enum.map(fn element ->
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
