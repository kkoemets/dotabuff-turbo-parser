defmodule KvParserTest do
  use ExUnit.Case

  doctest Kv.KvParser

  test "get ad elements" do
    Kv.KvParser.get_ad_elements()
  end

end
