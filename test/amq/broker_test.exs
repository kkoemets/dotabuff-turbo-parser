defmodule BrokerTest do
  use ExUnit.Case

  doctest Broker

  test "send email" do
    Broker.send_email(%{key_test: "value_test"})
  end
end
