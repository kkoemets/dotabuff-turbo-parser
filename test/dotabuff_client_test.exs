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

  test "parse match id" do
    row = get_test_row()

    assert String.contains?(
             DotabuffClient.parse_match_id(DotabuffClient.get_columns(row)),
             "7292524009"
           )
  end

  test "parse datetime" do
    row = get_test_row()

    assert String.contains?(
             DotabuffClient.parse_datetime(DotabuffClient.get_columns(row)),
             "2023-08-19T14:20:09+00:00"
           )
  end

  test "parse result" do
    row = get_test_row()

    assert String.contains?(
             DotabuffClient.parse_result(DotabuffClient.get_columns(row)),
             "Radiant Victory"
           )
  end

  test "parse radiant team" do
    row = get_test_row()

    assert DotabuffClient.parse_radiant_team(DotabuffClient.get_columns(row)) == [
             "phantom-assassin",
             "bloodseeker",
             "mirana",
             "dark-seer",
             "clinkz"
           ]
  end

  test "parse dire team" do
    row = get_test_row()

    assert DotabuffClient.parse_dire_team(DotabuffClient.get_columns(row)) == [
             "meepo",
             "lina",
             "morphling",
             "legion-commander",
             "arc-warden"
           ]
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

  def get_test_row() do
    {:ok, html_rows} = get_test_rows()
    {:ok, document} = Floki.parse_document(html_rows)
    rows = DotabuffClient.remove_first_element(Floki.find(document, "tr"))
    Enum.at(rows, 0)
  end

  def remove_linebreaks(html) do
    String.replace(html, ~r/\n/, "")
  end
end
