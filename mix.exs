defmodule Whithat.MixProject do
	use Mix.Project

	def project do
		[
			app: :whithat,
			version: "0.1.0",
			elixir: "~> 1.11",
			elixirc_paths: ["src", "lib"],
			start_permanent: Mix.env() == :prod,
			deps: deps(),
			escript: escript()
		]
	end

	# Run "mix help compile.app" to learn about applications.
	def application do
		[
			extra_applications: [:logger]
		]
	end

	# Run "mix help deps" to learn about dependencies.
	defp deps do
		[
			{:standard, git: "https://gitlab.com/Theopse/standard.git", branch: :Development},
			{:download, git: "https://gitlab.com/Theopse/download.git", branch: :Development},
			{:bradot, git: "https://gitlab.com/Theopse/bradot.git", branch: :Development},
			{:progress_bar, "~> 2.0"},
			{:tharray, git: "https://gitlab.com/Theopse/tharray.git", branch: :Development}, # https://gitlab.com/Theopse/tharray.git
			# {:dep_from_hexpm, "~> 0.3.0"},
			# {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
		]
	end
	defp escript do
		[main_module: Whithat.CLI]
	end
end
