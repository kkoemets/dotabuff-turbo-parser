require Logger

defmodule Okidoki.OkidokiClient do
  @web_driver_client Application.compile_env(:elixir_web_scraping, Okidoki.OkidokiClient, [])
                     |> Keyword.get(:web_driver_client, WebDriverClient)

  def get_search_results_html do
    Logger.info("Getting search results HTML")

    case @web_driver_client.get_html(
           "https://www.okidoki.ee/buy/1403/?sort=4&query=iphone%2013%20pro%20max&pp=200"
         ) do
      {:ok, html} ->
        Logger.info("Search results HTML received")
        {:ok, html}

      {:error, reason} ->
        Logger.error("Error occurred while getting search results HTML: #{inspect(reason)}")
        {:error, reason}
    end
  end

  def get_offer_html(href) do
    Logger.info("Getting offer HTML, href: #{href}")

    case @web_driver_client.get_html("https://www.okidoki.ee#{href}") do
      {:ok, html} ->
        Logger.info("Offer HTML received, href: #{href}")
        {:ok, html}

      {:error, reason} ->
        Logger.error("Error occurred while getting offer HTML: #{inspect(reason)}")
        {:error, reason}
    end
  end
end
