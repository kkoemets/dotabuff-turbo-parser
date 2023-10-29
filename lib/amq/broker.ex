require Logger
require Jason

defmodule Broker do
  use AMQP

  def send_email(data) do
    Logger.info("Sending message to send email")

    {:ok, connection} = AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)

    Logger.info("Queue message payload: #{inspect(Jason.encode!(data, pretty: true))}")

    AMQP.Basic.publish(channel, "", "send_email_queue", Jason.encode!(data))

    Logger.info("Message sent!")
  end
end
