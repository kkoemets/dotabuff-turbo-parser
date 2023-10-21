defmodule Okidoki.OkidokiParser do
  @moduledoc """
    Documentation for Okidoki.OkidokiParser
  """

  @okidoki_client Application.compile_env(:elixir_statistics, Okidoki.OkidokiParser, [])
                  |> Keyword.get(:okidoki_client, Okidoki.OkidokiClient)

  def get_offer_links do
    @okidoki_client.get_search_results_html
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
  end

  def get_offer_details(offer_link) do
    @okidoki_client.get_offer_html(offer_link)
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
          href: offer_link
        }
    end
  end
end
