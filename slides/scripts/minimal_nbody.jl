#------------minimal_nbody.jl--------------------------------------------------#
#
# Purpose: This is a minimal script to show how to make an nbody simulator in
#          Julia with KernelAbstractions
#
#   Notes: an NBody simulator is essentially composed of 3 parts:
#          1. A pairwise force (like gravity) that explains how 2 particles
#             interact
#          2. A way to go through all particles in the system and sum all the
#             forces to find the acceleration of each particle (F = ma)
#          3. A way to update each particle's position based on it's
#             velocity and acceleration
#------------------------------------------------------------------------------#

# These are needed to use the GPU. You have a choice between Nvidia (CUDA) and 
# AMD (AMDGPU). You can load these without having the GPU available on your
# machine, so to make sure your code can be run on any machine, just load both,
# and then specify which set of kernels you want in KernelAbstractions
using CUDA, AMDGPU
using KernelAbstractions

# This is so we can represent each point as an SVector (x,y,z...)
using StaticArrays

# for plotting...
using Plots

# Here we are loading the KernelAbstractions libraries for either CUDA / AMD
# depending on what GPU is available on your system
if has_cuda_gpu()
    using CUDAKernels
end

if has_rocm_gpu()
    using ROCKernels
end

# This is a simple struct to hold all data for the set of particles in the
# simulation. Note that we are using a struct of arrays so we can easily pass
# the information to the GPU
mutable struct Particles
    accelerations::Union{Array, CuArray, ROCArray}

    # Note: velocity is not strictly necessary for verlet integration
    velocities::Union{Array, CuArray, ROCArray}
    positions::Union{Array, CuArray, ROCArray}
    masses::Union{Array, CuArray, ROCArray}
end

# quick initialization function
function Particles(n; ArrayType = Array, box_size = 1, dims = 2)
    accelerations = ArrayType([SVector(Tuple(zeros(dims))) for i = 1:n])
    velocities = ArrayType([SVector(Tuple(zeros(dims))) for i = 1:n])
    positions = ArrayType([SVector(Tuple(rand(dims)*box_size .- 0.5*box_size)) for i = 1:n])
    masses = ArrayType(ones(n))

    return Particles(accelerations, velocities, positions, masses)
end

# Here, I am using a separate force law to be passed into my kernels
# Note that F = (G*mass_1*mass_2/r^2) multiplied by some unit vector u
function gravity(position_1, position_2, mass_1, mass_2; G = 9.81)
    # first, we find r^2 (r2) and the unit vector
    r2 = sum((position_1 .- position_2).^2)
    unit_vector = (position_1 .- position_2) ./ sqrt(r2)

    return (G*mass_1*mass_2/r2) * unit_vector
end

# This is a configuration function that will decide what architecture to run the
# nbody kernel on
function find_accelerations(p::Particles;
                            force_law = gravity,
                            num_threads = 256, num_cores = 4)
    if isa(p.positions, Array)
        kernel! = nbody!(CPU(),num_cores)
    elseif isa(p.positions, ROCArray)
        kernel! = nbody!(ROCDevice(),num_threads)
    elseif isa(p.positions, CuArray)
        kernel! = nbody!(CUDADevice(),num_threads)
    end

    # Note that ndrange selects the number of threads to use overall
    kernel!(p.accelerations,
            p.positions,
            p.masses,
            force_law,
            ndrange = size(p.positions)[1])

end

# This is the nbody kernel to be run in KernelAbstractions on hardware 
# determined by the configuration function.
# Note the @kernel macro here tells KernelAbstractions to re-write your code
# into a lower level language (ie CUDA, AMDGPU, or just normal CPU)
@kernel function nbody!(accelerations, positions, masses, force_law)

    # This decides which thread on your GPU (or CPU) you are working with
    tid = @index(Global, Linear)

    # We are resetting the accelerations to 0 before summing the forces
    accelerations[tid] = accelerations[tid] .* 0

    for j = 1:size(positions)[1]
        if j != tid
            accelerations[tid] = accelerations[tid] .+
                                 force_law(positions[tid], positions[j],
                                           masses[tid], masses[j])
        end
    end

end

# This is the simplest method to move particles forward each timestep
# It is meant to be used after the accelerations have been found.
# To be honest, there is not much benefit to doing this step in KA
function verlet!(positions_current, positions_previous, accelerations, dt)

    positions_current .= positions_current*2 .- positions_previous .+
                        accelerations*dt*dt

end

function main(p::Particles, num_steps, dt)
    # initializing the last timestep as the current set of positions
    last_positions = copy(p.positions)

    for i = 1:num_steps
        wait(find_accelerations(p, force_law = gravity))
        verlet!(p.positions, last_positions, p.accelerations, dt)
        last_positions .= p.positions
    end

    return p
end

# plot with scatter(plot_array[:,1], plot_array[:,2])
function create_plot_array(p)
    plot_array = zeros(length(p.positions), length(p.positions[1]))

    for i = 1:length(p.positions[1])
        plot_array[:,i] .= [p.positions[j][i] for j = 1:length(pos)]
    end

    return plot_array
end
