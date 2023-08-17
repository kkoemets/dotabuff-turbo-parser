defmodule DotabuffClientTest do
  use ExUnit.Case
  doctest DotabuffClient

  test "gets html" do
    {:ok, html} = DotabuffClient.get_html()
    assert String.contains? html, "Turbo"
  end

  test "gets table" do
    {:ok, html} = DotabuffClient.get_html()
    assert String.contains? DotabuffClient.get_table(html), "<table><thead><tr><th>Match ID</th><th>Game Mode</th><th>"
  end

  test "gets rows" do
    {:ok, html} = DotabuffClient.get_html()
    assert String.contains? DotabuffClient.get_rows(DotabuffClient.get_table(html)), ">Dire Victory</a>"
  end

end
