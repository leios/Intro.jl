module NewPackage
export greet

using Plots
using KernelAbstractions

greet() = print("Hello People!")

include("nbody.jl")

end # module NewPackage
