# Everything you need to know about package development

Ok, now we have package development and basic syntax down.
There is still a lot more to programming: tests, documentation, etc.
Here, I'll show all that off

#### Revise.jl
Note: REWORK SECTION TO USE NEWPACKAGE INSTEAD OF PLOTS AS THIS IS MORE RELEVANT TO REVISE.JL

```
Backspace # to go back to the regular REPL
julia> using Plots
[ Info: Precompiling Plots [91a5bcdd-55d7-5caf-9e0b-520d859cae80]
```

It took a while, but everything seems to be precompiled.
Just for fun, let's close Julia and use `Plots` again.

```
julia> exit()
julia --project 
julia> using Plots
```

Hmm... That also took a while.
Not as long as before, but it wasn't quick.

As it turns out, Julia's precompile time is sometimes quite long.
If you are making a bunch of changes to a package, you might need to recompile your code again and again while bug hunting.
That kinda sucks.

## Testing, building, and interacting with github

### Testing
### CI
### Documentation
### TagBot

Ok, that's everything I can think of about package management in Julia.

