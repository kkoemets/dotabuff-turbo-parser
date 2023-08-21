defmodule KvParserTest do

  use ExUnit.Case
  doctest Kv.KvParser

  test "get ad elements" do
    assert Kv.KvParser.get_add_elements() == "hi"
  end

end
