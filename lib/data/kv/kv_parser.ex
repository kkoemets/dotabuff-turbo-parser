defmodule Kv.KvParser do
  @moduledoc """
  Documentation for `KvParser`.
  """
  @kv_client Application.compile_env(:elixir_statistics, Kv.KvParser, [])
             |> Keyword.get(:kv_client, Kv.KvClient)

  def get_ad_elements do
    html = @kv_client.get_html()

    {:ok, document} = Floki.parse_document(html)

    document
    |> Floki.find("div[data-page]")
    |> Floki.attribute("data-page")
    |> Jason.decode()
    |> case do
      {:ok, decoded_map} -> Map.get(decoded_map, "props")
    end
    |> Map.get("data")
    |> Map.get("data")
  end
end
