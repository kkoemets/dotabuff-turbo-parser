defmodule Kv.KvParser do
  @moduledoc """
  Documentation for `KvParser`.
  """
  @kv_client Application.compile_env(:elixir_statistics, Kv.KvParser, [])
             |> Keyword.get(:kv_client, Kv.KvClient)

  def get_add_elements do
    @kv_client.get_html()
    |> Floki.parse_document()
  end
end
