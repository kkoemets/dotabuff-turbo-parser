defmodule OkidokiClientTest do
  use ExUnit.Case

  doctest Okidoki.OkidokiClient

  test "get search results html" do
    assert Okidoki.OkidokiClient.get_search_results_html() != nil
  end

  test "get offer html" do
    assert Okidoki.OkidokiClient.get_offer_html("/item/iphone-13-pro-max/12409468") != nil
  end
end
