import Config

config :elixir_statistics, Kv.KvParser, kv_client: Kv.KvClientStub
config :elixir_statistics, Okidoki.OkidokiParser, okidoki_client: Okidoki.OkidokiClientStub
