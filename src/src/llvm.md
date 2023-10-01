# What is precompilation?

So your friend got you into Julia and claimed that it was "Just as fast as C, but as easy to use as python."
You then looked at the syntax and thought, "Ok. It's *fine* syntactically, but nothing spectacular."
You then decided to run a simple test to check the performance of your Julia code and wrote the following code in C:

```
#include<iostream>

int main()
    std::cout << "Hello world!" << std::endl;
end
```

to compare to Julia's:
```
println("Hello world!")
```

You then ran a simple `time` command in the terminal, only to find that Julia is, well, leagues slower than C.
You then might think to yourself, "Ah, ok. Maybe that's all compilation time and the runtime of C and Julia are actually the same."
In an attempt to get your bearings, you then also decide to test against a simlar script in python:

```
print("Hello world!")
```

Only to find that Julia is *actually slower than python*! So what gives? Why was your friend lying to you?

This is one of those little white lies that Julia users tell all the time.
Precompilation can be the slowest part of your code, sometimes by a mile!


# Can we just talk about LLVM?

So we say that all julia code compiles down to LLVM just like C, but what does that actually mean?
