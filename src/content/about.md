# About this Book

The Intro.jl project is intended first and foremost as a book for people to thumb through and better understand the basics of Julia; however, it is also purposefully available for free online for anyone who wants or needs it.
It will also be used as a go-to reference for any course I teach about Julia moving forward.

The point of this book is to kickstart your journey into the Julia language and serve as a quick and easy reference to look through when you are stumped.
Overall, the hope is that you spend as little time as possible reading so you can spend more time actually doing the fun part: developing code.

## Why I care about Julia

I am Dr. James Schloss.
I completed my PhD at the Okinawa Institute of Science and Technology Graduate University in 2019 and then proceeded to work with the JuliaLab at MIT before launched my own consulting company known as LeiosLabs.
I have a youtube and twitch channel under the same name.

At the time of writing, my expertise is varied, but I primarily focus on General Purpose Graphics Processing Unit computation (also known as GPU computing or GPGPU).
On such devices, I have done climate modeling, molecular dynamics, superfluid simulations, computer graphics work, etc.
I know I am missing a few key areas of computational research, but I have done "most of it" and am quite disappointed in both the state of the art and state of knowledge in the general programming population.

Simply put, scientific computation (and in particular GPGPU) is with incredibly outdated tooling and workflows that limit the field as a whole.
Scientists often don't know how to write proper software and software engineers do not know how to do proper science.
Even so, scientists *do* have interesting computational challenges and are often the most heavy users of High Performance Computers (HPCs or supercomputers), which are essentially parallel computers stitched together in a distributed network.
Nowadays, even  Central Processing Units (CPUs) are becoming increasingly more parallel, meaning that modern programmers *must* deal with parallelism in some way.

This is where Julia comes in.
As a programming language, it is good.
It has a modern, in-built package manager, great open source ecosystem, decent memory management tooling, etc.
Where it really shines, though, is in it's GPGPU tooling.
There is no other language (that I know of) that gives you easier access to the GPU for computational tasks.

That is why I am interested in Julia as a language and why I want to see it succeed in it's mission to bring modern tooling to scientists and (hopefully) tackle some interesting software challenges along the way.

For the record, this book will not be an intro to GPGPU (though we will touch on it).
Instead, this is meant as a general introduction to the Julia language for those who might want a quick guide.
I'll (hopefully) be writing a follow-up guide in the future about GPGPU and using Julia as my primary language.
