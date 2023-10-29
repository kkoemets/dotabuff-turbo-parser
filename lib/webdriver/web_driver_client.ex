require Logger

defmodule WebDriverClient do
  use Hound.Helpers

  def get_html(url) do
    try do
      Hound.start_session()
      navigate_to(url)
      html = page_source()
      Hound.end_session()
      {:ok, html}
    catch
      :error, reason ->
        Logger.error("Error occurred while getting HTML: #{inspect(reason)}")
        {:error, reason}
    end
  end
end
