using Plots

export run

abstract type AbstractParticle end;

struct MassParticle{T} <: AbstractParticle
    position::T
    velocity::T
    acceleration::T
    Mass::Float64
end

struct SimpleParticle{T} <: AbstractParticle
    position::T
    velocity::T
    acceleration::T
end

function gravity(p1::MassParticle, p2::MassParticle;
                 G = 1)
    r2 = sum((p2.position .- p1.position).^2)
    unit_vector = (p2.position .- p1.position) ./ sqrt(r2)
    return (G*p2.mass/(r2+1)) .* unit_vector
end

function gravity(p1::AbstractParticle, p2::AbstractParticle;
                 G = 1)
    r2 = sum((p2.position .- p1.position).^2)
    unit_vector = (p2.position .- p1.position) ./ sqrt(r2)
    return (G/(r2+1)) .* unit_vector
end

function find_acceleration(p1::AbstractParticle, p2::AbstractParticle;
                           force_law = gravity)
    return force_law(p1, p2)
end

function kinematic(position, velocity, acceleration, dt)
    return position .+ velocity*dt .+ 0.5*acceleration*dt*dt
end

function move_particle(p::SimpleParticle, new_acceleration, dt;
                       routine = kinematic)
    new_velocity = new_acceleration*dt .+ p.velocity
    new_position = routine(p.position, new_velocity, new_acceleration, dt)
    SimpleParticle(Tuple(new_position),
                   Tuple(new_velocity),
                   Tuple(new_acceleration))
end

function create_n_rand_particles(n, dim)
    [SimpleParticle(Tuple(2*rand(dim) .- 1),
                    Tuple(2*rand(dim) .- 1),
                    Tuple(2*rand(dim) .- 1)) for i = 1:n]
end

function create_position_array(p::Vector{AP}) where AP <: AbstractParticle
    dims = length(p[1].position)
    arr = zeros(length(p), dims)
    for i = 1:length(p)
        for j = 1:dims
            arr[i,j] = p[i].position[j]
        end
    end

    return arr
end

function run(n_particles::Int, n_steps::Int; dt = 0.01, dim = 2,
             plot_steps = 10)
    particles = create_n_rand_particles(n_particles, dim)
    accelerations = zeros(n_particles, dim)
    for i = 1:n_steps
        Threads.@threads for j = 1:n_particles
            accelerations[j,:] .= 0
            for k = 1:n_particles
                if j != k
                    accelerations[j,:] .+= find_acceleration(particles[j],
                                                             particles[k])
                end
            end
        end 
        Threads.@threads for j = 1:n_particles
            particles[j] = move_particle(particles[j],
                                         accelerations[j,:], dt)
        end

#=
        if i % plot_steps == 0
            arr = create_position_array(particles)
            plt = Plots.scatter(arr[:,1], arr[:,2],
                                xlims = (-2, 2), ylims = (-2, 2))
            filename = "out"*lpad(i, 5, "0")*".png"
            savefig(plt, filename)
        end
=#
    end 
end
