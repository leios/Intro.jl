using Documenter

makedocs(
    sitename="Intro.jl",
    authors="James Schloss (Leios)",
    pages = [
        "Welcome" => "index.md",
        "Reviewer Guidelines" => "content/reviewers.md",
        "About the Author" => "content/about_me.md",
        "About this Book" => "content/about.md",
    ],
)

deploydocs(;
    repo="github.com/leios/Intro.jl",
)
