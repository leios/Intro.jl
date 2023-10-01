# Introduction to Julia

In casual conversation, the word "simple" is often used interchangeably with the phrase "easy to use"; however, when it comes to tools that we use on a daily basis, the two concepts might actually be opposite of each other.

For example, let's say you are asked to cut down a forest and are given the choice of two tools: either a chainsaw or an axe [^ For the record, I am not advocating that you *actually* cut down a forest. This discussion is purely hypothetical].
Clearly, the axe is simpler to use.
Just pick it up, point the bladed edge towards a tree, and chop.
The chainsaw, on the other hand, requires a bit more knowledge on how to power it, keep the chains lubricated, and ensure the safety of yourself and everyone around you.
Even with this added complexity, you would probably choose the chainsaw over the axe because it is simply way easier to chop down a bunch of trees with it.
In short: the axe is *simpler*, but the chainsaw is *easier to use*.

It's important to make this distinction with software as well.
Often times, the easiest software to use is also the most complicated under-the-hood.
Simulteneously, the simplest software is the hardest to use in practice.
Take C for example.
It is a simple programming language -- so simple, in fact, that it can be called from almost any other high-level language with ease.
It's also blazingly fast, often times the fastest language you could choose for most tasks.
So why not just code directly in C?
Because it's *too* simple.
It's missing a lot of the features modern-day users want: plotting, dynamic recompilation, safe memory management, and so on.

So why did I bring all this up?
Because Julia is simultaneously the easiest and most complicated programming language I know.

It has a dynamic shell (Read-Eval-Print-Loop, or REPL), just like Python which allows for fast prototyping.
It gets fantastic performance because all the functions compile down to LLVM, just like in C.
It has a great package manager, plotting utilities, and garbage collector for memory management.
It also has the best General-Purpose Graphics Processing Unit (GPGPU) ecosystem I have ever seen.

But surely there's a catch, right?
Yeah.
There certainly is.

With all of it's complexity, Julia (at the time of writing, 2023) cannot reliably generate an executable [^Note that it is possible to compile everything ahead-of-time with PkgCompiler.jl, but this leads to very large executable sizes which are not ideal for most applications], which means you need to wait for some (sometimes lengthy) pre-compile times every time you want to run code.
Also, as much as Julia wants to compete in the same space as languages like Python, it does not *quite* have the same user-base and is currently not used in many key areas, like game and web development.
Julia does a good enough job replacing data science languages like matlab, but the truth is that people using matlab do not usually want to switch languages.

So why?
Why use Julia in 2023?
Well, there could be a number of reasons.
Maybe you care a lot about performance, but are tired of maintaining so much C code.
Maybe you like matlab, but want more performance or are otherwise tired of paying the licensing costs.
Maybe you just want to be part of a vibrant open-source community of people working to make Julia great.

The point is that there are a lot of really good reasons to use Julia.
Just keep in mind that there is no such thing as a perfect language.
Like I said before, Julia is a chainsaw.
Sometimes you might still want an axe and that's totally ok!

Julia does not need to be the *only* language you use going forward, but I hope that (after reading this book), you'll find a couple of good uses for it that you might noth have otherwise known about.
