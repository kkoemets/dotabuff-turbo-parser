defmodule Kv.KvClient do
  @moduledoc """
  Documentation for KvClient.
  https://www.kv.ee/kinnisvara/korterid_yyr?rental=1&county=1&parish=1061&search_type=new&view=gallery&orderby=cd&start=50
  """
  require Logger

  @behaviour Kv.KvClientBehaviour
  @doc false
  def get_html do
    "get_html"
  end
end
