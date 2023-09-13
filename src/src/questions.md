# Other Questions

Here is a list of various questions I have received that didn't *quite* fit into any of the other chapters

## Julia on an Air-Gapped System

An air-gapped system is basically one that cannot connect to the internet during program execution.
This ultimately means that users connect to the system via USB and run the code from a direct, physical connection.
In principle, Julia should have no problem with this; however, one of the key shortcomings of Julia is that it is not able to generate an executable and might accidentally pull packages from the Julia Registry during precompilation.
Because of this, there are a couple of strategies one might use to get Julia working in such an environment.

## PkgCompiler

## Build everything ahead-of-time
