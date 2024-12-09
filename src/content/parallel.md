# Simple Parallelization with Julia

Years ago, computers were simple.
Code would run on a single core that would quickly execute a single task before moving on to the next one.
In a sense, many people write code with such simple devices in mind; however, this model is strictly theoretical.
The computational world today is increasingly parallel.
Even my oldest working computer (now over decade old) has at 2 cores available, and these cores are hyperthreaded meaning they can each do two tasks at once.

This means that if you write your code as a single set of instructions to execute on a single core, you are leaving up to 4x performance on the table!

The problem is that so much code is written with a single core in mind and it's hard to re-configure this code to work effectively on multiple processors

* SIMD vs other forms of parallelism (focus on simd because this is a quickstart)
* bootlegging other code
* kernel proramming
* touch on GPGPU


## Threads

## Kernel Programming

## GPGPU

* broadcasting on GPUArrays
* Just using a kernel
