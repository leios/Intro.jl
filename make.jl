using Documenter

makedocs(
    sitename="Intro.jl",
    authors="James Schloss (Leios) and contributors",
    pages = [
        "Welcome" => "src/index.md",
        "About this Book" => "src/about.md",
    ],
)

deploydocs(;
    repo="github.com/leios/Intro.jl",
)
