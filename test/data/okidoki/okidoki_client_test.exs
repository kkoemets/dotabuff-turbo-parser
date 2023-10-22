defmodule OkidokiClientTest do
  use ExUnit.Case

  doctest Okidoki.OkidokiClient

  test "get search results html" do
    assert Okidoki.OkidokiClient.get_search_results_html() != nil
  end
end
