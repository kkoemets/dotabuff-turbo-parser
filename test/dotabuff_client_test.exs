defmodule DotabuffClientTest do
  use ExUnit.Case
  doctest DotabuffClient

  test "gets html" do
    {:ok, html} = DotabuffClient.get_html()
    assert String.contains?(html, "Turbo")
  end

  test "gets table" do
    {:ok, html} = get_test_html()

    assert String.contains?(
             DotabuffClient.get_table(html),
             "<table><thead><tr><th>Match ID</th><th>Game Mode</th><th>"
           )
  end

  test "gets rows" do
    {:ok, html} = get_test_html()

    assert String.contains?(
             DotabuffClient.get_rows(DotabuffClient.get_table(html)),
             "th>Match ID</th>"
           )
  end

  test "create data" do
    {:ok, html_rows} = get_test_rows()
    DotabuffClient.create_data(html_rows)
  end

  def get_test_html() do
    {:ok, file_content} = File.read("test/turbo_sample_page.html")
    html = remove_linebreaks(IO.chardata_to_string(file_content))
    {:ok, html}
  end

  def get_test_rows() do
    {:ok, file_content} = File.read("test/sample_rows.html")
    html_rows = remove_linebreaks(IO.chardata_to_string(file_content))
    {:ok, html_rows}
  end

  def remove_linebreaks(html) do
    String.replace(html, ~r/\n/, "")
  end
end
