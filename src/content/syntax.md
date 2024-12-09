Notes: Add example problems?
# General Julia Syntax

There are certain "building blocks" of code that almost every language provides to it's users: loops, conditionals (`if...else if...else`), functions, structs (or classes).
These are fundamental to how users interface with code and reason about problems.
When languages do not provide such features, they are often labelled as esoteric because they usually require fundamentally different approaches to certain problems.
Luckily, Julia is not an esoteric language.
It provides everything a modern programmer might want (and more)!

In particular, Julia provides a really robust type system that pairs well with struct definitions.
It also provides broadcasting operations, which create custom element-wise operations.

In this chapter, we will start with the simplest programming structures and build towards the more complex.

## Printing

The first thing many people do when learning a new programming language is a simple "Hello World!" program.
In Julia, it's:

```
print("Hello World!")
```

The word "print" here more accurately means "output the provided set of characters to the terminal."
The set of characters `"Hello world"` is specified as a `String` with double quotation marks, while a single character can be specified with single quotes (such as `'a'`).
In Julia, it is more common to print both a string and a new line together with the "print line" command:

```
println("Hello World!")
```

Which does the same thing, but also moves the terminal position one line forward.

If you are used to C-style printing, you can use `@printf` (and `@sprintf` if you want a string instead of directly outputting to the terminal) by first `using Printf`.
The syntax will not be fully covered here, but here are a few quick examples:

```
Using Printf
@printf("Hello %s", "World!")
```

This creates a string and then replaces the `%s` with the string that comes after it, in this case, `"World!"`.
Note that the `%s` format is specifically for strings, but you could use any of the following:

| -- | --- |
| Example format | replaced with ... |
| -- | --- |
| %s | `String` value |
| %.3e | number using scientific notation with 3 significant digits |
| %.2f | floating point number with 2 decimal digits |
| %.5i | number padded with an empty space `" "` for formatting |
| %0.5i | number padded with a 0 |
| %.6g | removes trailing zeros from an output number |

Again, it's probably best to stick to just `ptint` or `println`, but some for the sticklers who want it or for those who might need some other tooling, `printf` also exists.

Ok, now to cover a few more bits and bobs, like warnings and some quick notes on strings, themselves.

### Warnings, errors, and info statements.

Julia provides special types of printing for specific messages that you feel the user should *really* pay attention to.
These will provide a colored output in the terminal, and have slightly different functionalities and meanings.

#### Errors

When you call `error(...)` in Julia, it will stop the execution of the program and output a red error message along with the stacktrace (list of all functions leading to the error in the first place) so you can get some context.
For example:

```
julia> error("You did something wrong!")
ERROR: You did something wrong!
Stacktrace:
 [1] error(s::String)
   @ Base ./error.jl:33
 [2] top-level scope
   @ REPL[11]:1
```

Here, the stacktrace just has the error message and the `REPL`, as it was directly written in the REPL instead of inside of a function.
We will talk more about understanding stack traces later.

#### Warnings

Warnings are less destructive error messages.
They still let the user know that something *could* be going wrong, but will allow the program to procees without quitting it prematurely.
For example:

```
@warn("You might be doing something wrong...")
┌ Warning: You might be doing something wrong...
└ @ Main REPL[12]:1
```

The warning is colored in yellow.
Instead of outputting an entire stacktrace, it will let the user know the line number and file where the warning was written.
Again because this was done in the REPL, it simply states so.

#### Info statements

Finally, there are info statements.
These are not warning or errors, but let the user know about something they might not have before.

```
julia> @info("Hey, just letting you know...")
[ Info: Hey, just letting you know...
```

Info statements are colored in blue and do not print any sort of line number.

### A brief note on `String`s

Strings are essential to outputting information in Julia (and most programming languages).
To be honest, there is not too much to say about them except that:
1. They are signified with double quotes (`"this is a string."`)
2. Individual characters are signified with single quotes (`'a'`)
3. To concatenate (add together) two strings, use the `*` operator like so: `"Hello "*"World!"

## Conditionals

Conditionals are simply ways to say, "If this is true, do this, if not, do something else."
This necessarily relies on some boolean `true` / `false` value to determine which branch you want to go down.
So let's say you have a value `a` and want to do domething different if a is negative, between 0 and 1, or greater than 1.
In Julia, that statement might look something like this:

```
if a < 0
    println("a is negative")
elseif 0 <= a <= 1
    println("a is between 0 and 1")
elseif a > 1
    println("a greater than 1")
else
    error("Something broke")
end
```

In this case, it is evaluating 3 separate expressions to determine if any are true:
1. `a < 0`
2. `0 <= a <= 1`
3. `a > 1`

If none are true, it then proceeds to the `else` statement.

### Ternary operator

Julia also supports the usage of the ternary operator syntax for simple conditionals with a single boolean statement.
Following the example from above, if we have a variable `a` and want to see if it is negative, we might write a ternary operator like so:

```
a < 0 ? println("a is negative") : println("a is positive")
```

Here, the conditional comes first, followed by a question mark (`?`).
In this case, the conditional is `a < 0`.
If the conditional is true, then the program will execute the first option before the colon (`:`), which is `println("a is negative")` in this case.
If the conditional is false, the program will execute the second option after the colon (`:`), which is `println("a is positive")` in this case.

To be honest, I am personally torn on ternary usage.
There are certain casses where it can certainly be useful and will help clean up code; however, if the operator becomes greater than a line or two, it is more convenient to just write the `if` / `else` block.

Both of these operations boil down to the same code, so there is no performance reason to choose one over another for most cases.
So just be careful and always try to write code that is easy for others to understand.

### Logical operations and expressions

When it comes to conditionals, it's really important to flexibly write whatever expression you might need to evaluate as true or false.
Luckily, most of these expressions have very clear logic that can be understood from conversational language.

|---|---|
| Expression | Meaning |
|---|---|
| > | Greater than |
| < | Less than |
| >= | Greater than or equal to |
| <= | Less than or equal to |
| == | Equal to |
| != | Not equal to |

As all of these operations will create a boolean value and we are ultimately evaluating a boolean, there are conditional versions of boolean operators, for example:

|---|---|
| Operation | Meaning |
|---|---|
| ! | Not |
| && | And |
| || | Or |

It is also totally fine to use the real boolean operators, like `&` and `|`, but what exactly is the difference between `&&` and `&`?
What's the point in using the same symbol twice?
Well, the `&&` and `||` operators are technically known as "short circuit" operators that will only evaluate the second argument if necessary.
For example:

```
isa(a, Number) && a < 0
```

Would first evaluate if `a` is a `Number` and then evaluate `a < 0` only if the first conditional is true.
ADD BETTER EXAMPLE: I am introducing types too early
ALSO ADD OR EXAMPLE

## Common Data Structures

In basically any programming language, there is some way to collect data into a single structure.
There are many such structures in Julia and 

### Arrays
#### Notes on types
### Tuples
### Dictionaries
### Stacks and Queues

## Loops

There is an old addage, "Insanity is doing the same thing over and over again and hoping for a different result."[^This idea is often attributed to Eindtein, but to be honest, I couldn't find conclusive evidence of Einstein ever saying something like it.]
This is a ridiculous claim.
Every day, we do the same things over and over for many different reasons.

Why? Well, for many reasons...
* We could be practicing or refining certain skills.
* We could be building something that is made of a bunch of small steps.
* We could be going through a list of items to check their quality.

No matter the case, doing the same thing over and over again is called *iteration* and it's not a sign of insanity, but a core component to how we think and reason about the world.
As such, Julia provides the ability to iterate through *loops*, which are common constructs that execute a block of code and the *loop back* to the start of the block again and again until a certain condition is met.

As an important point (for those migrating from languages like Matlab), looping *does not come with any sort of performance penalty in Julia*.
Remember that Julia boils down to the same code representation as C, so such basic programming constructs will have similar performance.
So don't be afraid, loop to your heart's content![^ Your heart beating is also a form of iteration, but I digress...]

I'll now introduce the two primary looping constructs: `for` and `while`.


### `while` loops

These loops just keep going until a conditional is `false`.
So, as a quick example, let's say you want to move a ball forward until it hits a wall.
You might write something like:

```
ball_position = 0.0
wall_position = 10.0
step_size = 1.0

while ball_position < wall_position
    ball_position += step_size
end
```

Here, the `ball_position`, `wall_position`, and `step_size` were all arbitrarily chosen.
Note that `while` loops might not continue going on forever unless the conditional is evaluated as false.
Because of this, each `while` loop should address the conditional in the loop, itself.
In this case, because the `ball_position` must be greater than the `wall_position` for the loop to terminater, we are adding `step_size` to it every iteration.

### `for` loops

Unlike `while` loops, `for` loops will iterate through some iterable object like a list or range of numbers.
To be honest, I usually like splitting this up into two different types of looping:
1. Looping through a range of numbers
2. Looping through a collection of items

#### Looping through a range of numbers
#### Looping through a collection of items


## include()
## Types (and supertypes)
## Structs
## Functions
Also cover !
Multiple dispatch
## Broadcasting
## macros
