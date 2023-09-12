module Intro
using Documenter

makedocs(
    sitename="Intro to Julia",
    authors="James Schloss (Leios) and contributors",
    pages = [
        "General Information" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/leios/Intro.jl",
)
end
