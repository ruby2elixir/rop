defmodule Rop.Mixfile do
  use Mix.Project

  def project do
    [app: :rop,
     version: "0.5.0",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:ex_spec, "~> 1.0", only: :test}]
  end


  defp package do
    [
     maintainers: ["Roman Heinrich"],
     contributors: ["Remigiusz Jackowski", "Zohaib Rauf"],
     licenses: ["MIT License"],
     description: "Some convenient macros to enable railsway-oriented programming in Elixir",
     links: %{github: "https://github.com/ruby2elixir/rop"}]
  end

end
