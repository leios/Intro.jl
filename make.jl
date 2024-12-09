module Intro
using Documenter

makedocs(
    sitename="Intro.jl",
    authors="James Schloss (Leios)",
    pages = [
        "Welcome" => "index.md",
        "Reviewer Guidelines" => "content/reviewers.md",
        "About the Author" => "content/about_me.md",
        "Let's Be Honest About Julia" => "content/intro.md",
        #"Development Environments" => "ides.md",
        #"Packages" => "packages.md",
        #"General Syntax" => "syntax.md",
        #"General Development" => "development.md",
        #"Plotting" => "plotting.md",
        #"Parallelization" => "parallel.md",
        #"Performance Notes" => "performance.md",
        #"Benchmarking" => "benchmarks.md",
        #"Debugging" => "debug.md",
        #"Other Questions" => "questions.md",
    ],
)

deploydocs(;
    repo="github.com/leios/Intro.jl",
)
end
