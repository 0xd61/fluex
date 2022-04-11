defmodule Fluex.MixProject do
  use Mix.Project

  def project do
    [
      app: :fluex,
      version: "0.1.1",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      compilers: [:rustler] ++ Mix.compilers(),
      rustler_crates: rustler_crates(),
      description: "Localization system for natural-sounding translations using fluent-rs",
      package: package(),
      deps: deps()
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["Kaitsh <kaitsh@d-git.de"],
      licenses: ["Apache License 2.0"],
      files: ~w(lib native mix.exs README* LICENSE*),
      links: %{"GitHub" => "https://github.com/kaitsh/fluex"}
    ]
  end

  defp rustler_crates do
    [
      fluent_nif: [
        path: "native/fluent_nif",
        cargo: :system,
        default_features: true,
        features: [],
        mode: (if Mix.env == :prod, do: :release, else: :debug),
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      env: [default_locale: "en"],
      mod: {Fluex.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:rustler, "~> 0.25.0"}
    ]
  end
end
