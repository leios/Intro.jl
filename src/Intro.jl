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
        "Plotting" => "plotting.md",
        "Parallelization" => "parallel.md",
        "Benchmarking" => "benchmarks.md",
        "Debugging" => "debug.md",
        "Introspection" => "introspect.md",
        "Other Questions" => "questions.md",
    ],
)

deploydocs(;
    repo="github.com/leios/Intro.jl",
)
end
