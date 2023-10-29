require Logger

defmodule Okidoki.OkidokiParser do
  @moduledoc """
    Documentation for Okidoki.OkidokiParser
  """

  @okidoki_client Application.compile_env(:elixir_web_scraping, Okidoki.OkidokiParser, [])
                  |> Keyword.get(:okidoki_client, Okidoki.OkidokiClient)

  def get_offers_data do
    get_offer_links()
    |> Enum.chunk_every(3)
    |> Enum.flat_map(fn batch ->
      batch
      |> Enum.map(fn x -> Task.async(fn -> get_offer_details(x) end) end)
      |> Enum.map(fn task -> Task.await(task, 75000) end)
    end)
  end

  def get_offer_links do
    case @okidoki_client.get_search_results_html do
      {:ok, html} ->
        html
        |> Floki.parse_document()
        |> case do
          {:ok, document} ->
            document
            |> Floki.find("li[class='classifieds__item']")
            |> Enum.map(fn x ->
              x
              |> Floki.find("a[class='horiz-offer-card__title-link']")
              |> Floki.attribute("href")
            end)
        end

      {:error, reason} ->
        Logger.error("Error occurred while getting offer links: #{inspect(reason)}")
        []
    end
  end

  def get_offer_details(offer_link) do
    case @okidoki_client.get_offer_html(offer_link) do
      {:ok, html} ->
        html
        |> Floki.parse_document()
        |> case do
          {:ok, document} ->
            %{
              title: Floki.find(document, "h1[itemprop='name']") |> Floki.text(deep: false),
              price: Floki.find(document, "p[class='price']") |> Floki.text(deep: false),
              description:
                Floki.find(document, "div[class='description']")
                |> Floki.find("p")
                |> Floki.text(deep: false),
              created_at:
                Floki.find(document, "div[class='stats-views__item']")
                |> List.last()
                |> Floki.find("span")
                |> Floki.text(deep: false)
                |> String.replace("Lisatud:", "")
                |> String.trim(),
              href: offer_link
            }
        end

      {:error, reason} ->
        Logger.error("Error occurred while getting offer details: #{inspect(reason)}")
        {:error, reason}
    end
  end
end
