require Logger

defmodule WebDriverClient do
  use Hound.Helpers

  def get_html(url) do
    try do
      Logger.info("Getting HTML for #{url}")
      Hound.start_session()
      navigate_to(url)
      html = page_source()
      Hound.end_session()
      Logger.info("Got HTML for #{url}")
      {:ok, html}
    catch
      :error, reason ->
        Logger.error("Error occurred while getting HTML: #{inspect(reason)}")
        {:error, reason}
    end
  end
end
