require Logger

defmodule Broker do
  use AMQP

  def send_email(data) do
    Logger.info("Sending message to send email")

    {:ok, connection} = AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)

    AMQP.Basic.publish(channel, "", "send_email_queue", data)

    Logger.info("Message sent!")
  end
end
