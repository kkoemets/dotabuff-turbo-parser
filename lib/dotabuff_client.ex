defmodule DotabuffClient do
require Logger

  @doc false
  def get_html() do
    Logger.info "Getting HTML"
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
    Logger.info "Getting table"
    {:ok, document} = Floki.parse_document(html)
    Floki.raw_html(Floki.find(document, "table"))
  end

  @doc false
  def get_rows(html_table) do
    Logger.info "Finding rows"
    {:ok, document} = Floki.parse_document(html_table)
    Floki.raw_html(Floki.find(document, "tr"))
  end
end
