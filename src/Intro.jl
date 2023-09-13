module Intro
using Documenter

makedocs(
    sitename="Intro to Julia",
    authors="James Schloss (Leios) and contributors",
    pages = [
        "General Information" => "index.md",
        "Performance Notes" => "performance.md",
        "Development Environments" => "ides.md",
        "General Syntax" => "syntax.md",
        "Packages" => "packages.md",
        "Plotting" => "plotting.md",
        "Parallelization" => "parallel.md",
        "Benchmarking" => "benchmarks.md",
        "Debugging" => "debug.md",
        "Other Questions" => "questions.md",
    ],
)

deploydocs(;
    repo="github.com/leios/Intro.jl",
)
end
