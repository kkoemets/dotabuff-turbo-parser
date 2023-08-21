defmodule Kv.KvClientStub do
  @moduledoc """
    Documentation for Kv.KvClientStub
  """

  @behaviour Kv.KvClientBehaviour
  def get_html do
    {:ok, file} = File.read("test/kv/kv_sample_page.html")
    file |> IO.chardata_to_string()
  end
end
