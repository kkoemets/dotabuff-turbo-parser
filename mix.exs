defmodule ElixirDemo.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_web_scraping,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths:
        if Mix.env() == :test do
          ["lib", "test"]
        else
          ["lib"]
        end
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :mix, :quantum],
      mod: {ElixirWebScraping.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:httpoison, "~> 2.1.0"},
      {:floki, "~> 0.34.3"},
      {:jason, "~> 1.4"},
      {:dialyxir, "~> 1.3", only: [:dev], runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:mox, "~> 1.0", only: :test},
      {:amqp, "~> 3.3"},
      {:quantum, "~> 3.5"},
      {:hound, "~> 1.0"}
    ]
  end
end
