defmodule Okidoki.OkidokiClientStub do
  @moduledoc """
    Documentation for Okidoki.OkidokiClientStub
  """

  def get_search_results_html do
    {:ok, file} = File.read("test/data/okidoki/okidoki_sample_search_results_page.html")
    file |> IO.chardata_to_string()
  end

  def get_offer_html(offer_link) do
    if offer_link == "missing_data" do
      {:ok, file} =
        File.read("test/data/okidoki/okidoki_sample_offer_page__with_missing_data.html")

      file |> IO.chardata_to_string()
    else
      {:ok, file} = File.read("test/data/okidoki/okidoki_sample_offer_page.html")
      file |> IO.chardata_to_string()
    end
  end
end
