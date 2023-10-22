require Logger

defmodule Okidoki.OkidokiClient do
  def get_search_results_html do
    {:ok, body} =
      get_html("https://www.okidoki.ee/buy/1403/?sort=4&query=iphone%2013%20pro%20max&pp=200")

    body
  end

  def get_offer_html(url) do
    {:ok, body} = get_html(url)
    body
  end

  def get_html(url, headers \\ %{}) do
    Logger.info("Getting HTML")

    headers =
      Map.merge(headers, %{
        "User-Agent" =>
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3",
        "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
        "Accept-Language" => "en-US,en;q=0.5",
        "Referer" => "https://www.google.com/",
        "Connection" => "keep-alive",
        "Upgrade-Insecure-Requests" => "1",
        "Cache-Control" => "max-age=0"
      })

    case HTTPoison.get(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        {:error, "Received status code #{status_code}"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
