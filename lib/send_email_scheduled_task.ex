require Logger
require Broker

defmodule SendEmailScheduledTask do
  @moduledoc """
  Documentation for `SendEmailScheduledTask`.
  """

  @okidoki_parser Application.compile_env(:elixir_web_scraping, Okidoki.OkidokiParser, [])
                  |> Keyword.get(:okidoki_parser, Okidoki.OkidokiParser)

  def perform do
    Logger.info("Sending email")
    Broker.send_email(@okidoki_parser.get_offers_data())
  end
end
