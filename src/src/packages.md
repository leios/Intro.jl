Notes: Mention the word "dependencies" sooner
       add links (page numbers in the book) to where we talk about everything when I say "we'll talk about this later" <--- limit these!
# Package Management in Julia

When people think about programming, they often think of it as a solitary experience and might conjure up an image of a single developer typing furiously on their keyboard until the early hours of the morning with a trusted beverage in hand.
To be honest, this is only partially true.
I know many programmers who do their best work around or after midnight; however, programming (at least nowadays) is anything but solitary.

Code is almost always written with a team and for many different purposes.
It could be that you are writing a research paper with collegues and need to test some hypothesis.
It could be that you want to write software that can be used by many other people for any sort of purpose.
It could be that you are just hobby programming with friends.
No matter the case, it's important to write code that can be tested and produces the same result on any computer.
Nowadays, modern open source tooling makes it much easier to write such code and collaborate with other developers from around the world.
The problem is that most programming languages were developed without care for such tooling.

Here, Julia is different.
It was built with collaboration in mind and actively encourages the development of *packages* that integrate with it's package manager, which is a core component of the language and easily usable through the REPL.
These packages are easy to create and make it easy for anyone else to reproduce and test code on their local machines.
The package manager can also easily connect to version control systems like git and most packages are available on github.
To be honest, I might argue that package management is one of the most important parts of the Julia language.

This is why I put this chapter *before* the chapter on Julia syntax.
Package management is so fundamental to Julia that it's hard to write anything at all without using it in some capacity.
That said, this chapter will cover a lot more than just the basics, so it's important for you to go at your own pace.
Remember that this is a book.
You choose how you want to read it.

If you want to cover Julia syntax first, please skip or skim this chapter and come back when you are ready.
If you want to learn everything now, then go right ahead!

Take your time and enjoy the process.

## What is package management?

Let's say you want to install software.
What do you do?

Well, on Windows, you often google the software you want to install, click on the appropriate link, and then click the "download" button on the website (all while hoping and proaying you are not accidentally installing the wrong software -- or worse: a virus).
On Mac and IOS, you probably first try to see if the application is available on the App Store and then download it from there.
On Android, you use the Google Play Store.
On Linux, you interact with your package manager.

All of these are examples of package management.
The idea is simple: there is a software package somewhere online that the user wants to download to their own computer.
Someone or something needs to manage the package.
In the case of Windows, it is done by the user, themself.
On other devices, there is some software in the middle to do this instead.

So what does this have to do with Julia?

Well, the best software developers I know actively try to write as little code as possible.
Why?
Because it is fundamentally better to rely on other people who are already solving the same problem.

Let's say you want to do a ...`

In this case, you *could* write the algorithm yourself, but that's a lot of work.
It's fundamentlly easier to download a package from online that does the same thing.
More than that, the package you find online will probably be faster than whatever you were going to write because, well, you are probably learning about the algorithm for the first time while the package developer is (hopefully) an expert on the topic.

## Installing Packages

First things first, let's discuss how to install and use packages.
If you are working from the REPL, first enter package mode by pressing `]`. From there, your command prompt should turn blue and look like this:

```
(@v1.X) pkg>
```

From here, you can add (install) an package you want with:

```
(@v1.X) pkg> add Pkg
```

So (for example), if you want to plot some data, you might do:

```
(@v1.X) pkg> add Plots
```

Note that the Plots package is *technically* Plots.*jl*, but the *.jl* extension is removed by the package manager.

Once the package is loaded, press backspace to enter the regular REPL so your command prompt is green and looks like this:

```
julia>
```

Now you can use the package locally with:

```
julia> using Plots
```

This will take a second to download all of Plots's dependencies as well, but after that, you can use any function exported by Plots directly in your REPL.
You can also use the same syntax in any file for your own package(s).
If you want to use a non-exported function you can do so by calling `Plots.fx` where `fx` should be replaced by the function you want.
Note that there is some nuance to this that we will talk about with modules later.

Finally, if you want to remove `Plots`, just use the `rm` or `remove` command like so:

```
(@v1.X) pkg> rm Plots
```
or
```
(@v1.X) pkg> remove Plots
```

Note that if you do not want to use the REPL to do this any of this, you can do so by first `using Pkg` and then doing all the commands in the package mode of the REPL with the `Pkg` package.
For the Plots example above, this might look like:

```
using Pkg
Pkg.add("Plots")
using Plots
```

Also keep in mind that this particular version of `Plots.jl` will be pulled from a giant repository of all available Julia packages called a `Registry`.[^In particular *the* Julia Registry here: https://github.com/JuliaRegistries/General]
We'll talk more about that in a bit as well.


But wait.
What if your friend wants to run your code, but forgot to install Plots first?
Well, in that case, Julia will show an error message like so:

```
ADD  ERROR V 1.9
```

It will then prompt your friend to install the appropriate package.

But there's actually another way to make sure your friend is using not only the right packages, but the right package versions as well, and that's by creating your own package and sending that instead.
Each package is generally specified as a `project` and the next few sections will talk about them in detail.

## What is a project?

A `project` in Julia is anything set of coding scripts you are working on that need to work cohesively together.
The specific set of packages you need to get your code to run is available in the `Project.toml` file, which will be in the root (home) directory of your codebase.

So let's see this in action.
First, let's generate a new package from the REPL by first pressing the `]` key:

```
(@v1.X) pkg> generate NewPackage.jl
  Generating  project NewPackage:
    NewPackage.jl/Project.toml
    NewPackage.jl/src/NewPackage.jl
```

Here, we see that a new directory has been created with the name `NewPackage.jl` along with a `Project.toml` file and a new directory and file `src/NewPackage.jl`
Note that the `.jl` extension is not strictly necessary, but is common practice for julia package development.
At least for me, I typically use the `.jl` extension if I am writing code meant to be used by other people, but leave it off for my own scripts that are not intended for public use.

Now let's look into each file, starting with `Project.toml`:

```
cat NewPackage.jl/Project.toml 
name = "NewPackage"
uuid = "6c3339cd-44b7-4b24-89b3-44aad60a1695"
authors = ["James Schloss <jrs.schloss@gmail.com>"]
version = "0.1.0"
```

Ok, lot's to talk about:
1. `cat` is a terminal command that just shows the content of a file. Don't worry about it too much, I just showed the command for clarity.
2. `name` is the name you provided for the package. Note that the `.jl` extension is stripped in the actual package name.
3. The `uuid` is a "Universally Unique Identifier" and will be different for each person. `uuid` values are used a bunch throughout different areas of software engineering, but here they are used to differentiate packages, that way if two packages have the same name, they can still be uniquely identified [^ Note that there are some caveats here that we will talk about when discussing registering a package].
4. `authors` are the authors in the format typically used for git (and specifically github). Feel free to add new authors to this as necessary. And yes, that is my actual email. Feel free to send me a message if you want!
5. `version` is the version for your package and is set to `0.1.0` by default. This will be discussed in it's own section below.

Now let's see what's in the other new file:

```
cat NewPackage.jl/src/NewPackage.jl 
module NewPackage

greet() = print("Hello World!")

end # module
```

This is actually just a julia file with a basic "Hello World!" script.
There is not too much to say except that it is creating a `module` with a single component, the `greet()` function.
So how do we call this function?

The simplest way is to just `include` the file directly into the Julia REPL:

```
julia> include("NewPackage.jl/src/NewPackage.jl")
Main.NewPackage
julia> NewPackage.greet()
Hello World!
```

The second way is to start Julia up *with this specific project* so we can use it like any other package:

```
cd NewPackage.jl/
julia --project
julia> using NewPackage
[ Info: Precompiling NewPackage [6c3339cd-44b7-4b24-89b3-44aad60a1695]

julia> NewPackage.greet()
Hello World!
```

A couple things to note:
1. In the first method (just `include`ing the file, we are treating the package as a single file and otherwise using whatever packages we already have installed on our system.
2. In the second method, we are launching julia with the `--project` flag, which uses the packages in the `Project.toml` file. Right now, that file has no dependencies, but we'll talk about that in a second. To use this flag, you must specify *where the project is located*, which is in the current directory by default, but you could also use `julia --project=/path/to/Project.toml`.
3. When `using NewPackage`, there is a small delay where Julia precompiles not only the package, itself, but also any other necessary packages and functions.
4. Finally, to call the `greet()` function, we need to call it from the module with `NewPackage.greet()`.

### Adding packages to your `Project.toml`
Ok, let's keep going within the project that we created before (with `julia --project`).
What if our package needs some other package to work properly, how might we do this?

Well let's start by pressing `]` in the REPL. Now you should see this:

```
(NewPackage) pkg>
```

Immediately there is a subtle, but important difference: The `pkg>` prompt has `(NewPackage)` in parenthesis before it.
This means that the package manager will be directly modifying `NewPackage.jl`'s `Project.toml`, but keep everything else clean.
So now let's att `Plots` like before:

```
(NewPackage) pkg> add Plots
    Updating registry at `~/.julia/registries/General`
    Updating git-repo `https://github.com/JuliaRegistries/General.git`
   Resolving package versions...
   Installed GR_jll ──────────────────── v0.72.9+1
   ...
   Installed UnitfulLatexify ─────────── v1.6.3
  Downloaded artifact: GR
  ...
  Downloaded artifact: Xorg_libXdmcp
    Updating `~/projects/stuff/NewPackage.jl/Project.toml`
  [91a5bcdd] + Plots v1.39.0
    Updating `~/projects/stuff/NewPackage.jl/Manifest.toml`
  [d1d4a3ce] + BitFlags v0.1.7
  ...
  [3f19e933] + p7zip_jll
Precompiling project...
  ✓ NewPackage
  114 dependencies successfully precompiled in 163 seconds (26 already precompiled)
  1 dependency precompiled but a different version is currently loaded. Restart julia to access the new version
```

What a nightmare!
The truth is that Plotting is actually kinda complicated and there is a lot going on, so let me try to break it down:

#### Step 1: Updating the registry
```
    Updating registry at `~/.julia/registries/General`
    Updating git-repo `https://github.com/JuliaRegistries/General.git`
```
This is doing what is says, updating your local versions of the Julia registry to make sure it's up-to-date.

#### Step 2: Installing necessary packages
```
   Installed GR_jll ──────────────────── v0.72.9+1
   ...
   Installed UnitfulLatexify ─────────── v1.6.3
```
All of these are downloading the necessary dependencies for `Plots`

#### Step 3: Downloading artifacts
```
  Downloaded artifact: GR
  ...
  Downloaded artifact: Xorg_libXdmcp
```
`artifact`s are anything Packages need that are not packages themselves.
`Plots.jl` uses a lot of these becuase it needs to do a lot of semi-complicated things, like opening up windows on your local system, which could be operating-system dependent.

#### Step 4: Updating `Project.toml` and `Manifest.toml`
```
    Updating `~/projects/stuff/NewPackage.jl/Project.toml`
  [91a5bcdd] + Plots v1.39.0
    Updating `~/projects/stuff/NewPackage.jl/Manifest.toml`
```
Now we are finally updating the Project.toml file with `Plots`, but also creating a new file called a `Manifest.toml`.
We'll cover this file more in a bit, but it's essentially a list of all the packages you need *and their dependencies* along with their unique identifiers and versions.
It is automatically generated and you generally don't need to think about it too much.

#### Step 5: Precompilation of the full project
```
Precompiling project...
  ✓ NewPackage
  114 dependencies successfully precompiled in 163 seconds (26 already precompil
ed)
  1 dependency precompiled but a different version is currently loaded. Restart 
julia to access the new version
```
Finally, we are precompiling our `NewProject` to make sure that adding the new package doesn't mess up any of the functionality we already have.
Once done, it says that there are 114 dependencies precompiled and 1 precompiled with a different version.
That isn't a huge deal in most cases, but if you notice things acting funny later, you might want to restart Julia.

From now on, any time you load the NewPackage project, you will have `Plots` ready to go with just `using Plots`.
It will automatically load a version that works well with your project.

Keep in mind that all of these commands can be done by `using Pkg` and calling everything from a separate file instead of from the REPL.

Ok, that was a lot.
At this stage, we have talked about how to use basic packages and add them to basic projects, but there are lots of little things to talk about.
Let's tackle them one at a time.

## The `status` command

In the previous example, we added a new package called `Plots` to an existing project called `NewProject`.
That's all well and good, but Julia is an actively developed langauge and packages could change.
What if there is an issue with your, specific version of `Plots` and you want to go back to a previous version?
How would you even figure out such a thing?

Well, you can do so by looking at your `status` or `st`:

```
] # to enter package mode in the REPL
(NewPackage) pkg> st
     Project NewPackage v0.1.0
      Status `~/projects/stuff/NewPackage.jl/Project.toml`
  [91a5bcdd] Plots v1.39.0
```

Here, it shows that we are using `NewPackage v0.1.0` and `Plots v1.39.0`, as specified in our `Project.toml`
Now that we know our package versions we can play around with them.

!!! note On semantic versioning
    Julia uses Semantic Versioning, which means that there are 3 numbers associated with each version one for major changes, minor changes, and patches.
    For example, v1.2.3 would be on major version 1, minor version 2, and patch version 3.
    These version numbers are incredibly useful for ensuring that results from code can be replicated by other users.
    After all, two users could get radically different results if there were radical changes between package versions.

    By standardizing on semantic versioning, Julia can ensure the package manager can maintain a clear concept of which packages depend on each other and which versions of those packages are necessary to provide correct results.
    So for example, let's say that package A requires package B to be at v1.3.4 or older.
    If you install package A, the package manager will automatically lower the version of package B to 1.3.4 or older.
    Note that this can cause some complications and we'll talk about how to watch out for these when discussing the `status` of packages later.

### Lowering the package version
### using a specific git branch
"main" and "http"
### Developing local packages

## Additional notes on `Project.toml`
### deps
### compat
## Status conflicts

Limit `Plots` version in one package and then use a second package to show a few more conflicts.

## Registering a package
### Creating your own Registry

## Testing, building, and interacting with github

### Testing
### Building
### CI
### Documentation
### TagBot

## Manifests

## Revise.jl

Ok, that's everything I can think of about package management in Julia.
