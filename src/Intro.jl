module Intro
using Documenter

makedocs(
    sitename="Intro to Julia",
    authors="James Schloss (Leios) and contributors",
    pages = [
        "General Information" => "index.md",
        "About" => "about.md",
        "Development Environments" => "ides.md",
        "Packages" => "packages.md",
        "General Syntax" => "syntax.md",
        "General Development" => "development.md",
        "Plotting" => "plotting.md",
        "Parallelization" => "parallel.md",
        "Performance Notes" => "performance.md",
        "Benchmarking" => "benchmarks.md",
        "Debugging" => "debug.md",
        "Other Questions" => "questions.md",
    ],
)

deploydocs(;
    repo="github.com/leios/Intro.jl",
)
end
