import Config

import_config "#{Mix.env()}.exs"

config :elixir_web_scraping, Scheduler,
  jobs: [
    {"* * * * *", {SendEmailScheduledTask, :perform, []}}
  ]

config :hound, driver: "chrome_driver", browser: "chrome_headless"
