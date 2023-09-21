# About this Book

The Intro.jl project is intended first and foremost as a book for people to thumb through and better understand the basics of Julia; however, it is also purposefully available for free online for anyone who wants or needs it.
I will also be using this as my go-to reference for any course I teach about Julia moving forward.

All of the writing here will assume basic familiarity with some other programming language.
In particular, I will assume basic knowledge of loops, conditionals, functions, structs, etc.
I will explain how such features work syntactically in Julia, but I will not dive deeper into explaining how they work for those who are unfamiliar.

It is really important to read this book at your own pace.
I tried my best to collect all of my thoughts and write everything in the order that made the most sense to me, but we are different people.
If you are struggling or lack motivation to get through particular sections, take a breather or move on to another section.
In fact, some sections might not even be necessary for your workflow, and that's ok!
You don't have to read everything here!

The point of this book is to kickstart your journey into the Julia language and serve as a quick and easy reference to look through when you are stumped.
The hope is that you spend as little time as possible reading so you can spend more time actually doing the fun part: developing code.

## About the Author

I am Dr. James Schloss.
I completed my PhD at the Okinawa Institute of Science and Technology Graduate University in 2019 and then proceeded to work with the JuliaLab at MIT and then launched my own consulting company known as LeiosLabs.
I have a youtube channel under the same name.

At the time of writing, my expertise is varied, but I primarily focus on General Purpose Graphics Processing Unit computation (also known as GPU computing or GPGPU).
On such devices, I have done climate modeling, molecular dynamics, superfluid simulations, computer graphics work, etc.
I know I am missing a few key areas of computational research, but I have done "most of it" and am quite disappointed in both the state of the art and state of knowledge in the general programming population.

Simply put, scientific computation (and in particular GPGPU) is with incredibly outdated tooling and workflows that limit the field as a whole.
Scientists don't know how to write proper software and software engineers do not know how to do proper science.
Even so, scientists *do* have interesting computational challenges and are often the most heavy users of High Performance Computers (HPCs or supercomputers), which are essentially parallel computers stitched together in a distributed network.
Nowadays, even  Central Processing Units (CPUs) are becoming increasingly more parallel, meaning that modern programmers *must* deal with parallelism in some way.

This is where Julia comes in.
As a programming language, it is good.
It has a modern, in-built package manager, great open source ecosystem, decent memory management tooling, etc.
Where it really shines, though, is in it's GPGPU tooling.
Simply put, there is no other language (that I know of) that gives you easier access to the GPU for computational tasks.

That is why I am interested in Julia as a language and why I want to see it succeed in it's mission to bring modern tooling to scientists and (hopefully) tackle some interesting software challenges along the way.

This book will not be an intro to GPGPU (though we will touch on it).
Instead, this is meant as a general introduction to the Julia language for those who might want a quick guide.
I intend to write more later about GPGPU and Julia in particular.


