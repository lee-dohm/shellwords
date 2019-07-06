defmodule Shellwords.MixProject do
  use Mix.Project

  def project do
    [
      app: :shellwords,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "> 0.0.0", only: :dev, runtime: false},
      {:version_tasks, "~> 0.11", only: :dev}
    ]
  end

  defp docs do
    [
      extras: [
        "README.md",
        "CODE_OF_CONDUCT.md": [
          filename: "code_of_conduct",
          title: "Code of Conduct"
        ],
        "LICENSE.md": [
          filename: "license",
          title: "License"
        ]
      ],
      main: "readme"
    ]
  end
end
