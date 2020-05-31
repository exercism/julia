using Test

import Random

include("robot-name.jl")

# Random names means a risk of collisions.
const history = Set{String}()

isname(x) = occursin(r"^[A-Z]{2}[0-9]{3}$", x)

@testset "one robot" begin
    global r1 = Robot()
    push!(history, name(r1))

    @testset "name of robot is valid" begin
        @test isname(name(r1))
    end

    @testset "names of robot instance are valid and unique in history" begin
        # @testset sets the same seed every time for reproducibility, but we're
        # undoing that deliberately with Random.seed!() to increase the chance
        # of seeing collisions.
        Random.seed!()
        for i in 1:100
            reset!(r1)
            @test isname(name(r1))
            @test !in(name(r1), history)
            push!(history, name(r1))
        end
    end
end

@testset "two robots" begin
    global r2 = Robot()
    global r3 = Robot()

    @testset "names of robots are valid" begin
        @test isname(name(r2))
        @test isname(name(r3))
    end
    
    @testset "names of robots are not equal" begin
        @test name(r2) != name(r3)
    end

    @testset "names of both robots are unique in history" begin
        @test !in(name(r2), history)
        @test !in(name(r3), history)
    end

    push!(history, name(r2))
    push!(history, name(r3))
end

@testset "many robots" begin
    Random.seed!()
    robots = Robot[]

    for i in 1:100
        push!(robots, Robot())

        @testset "name of robot is valid and unique in history" begin
            @test isname(name(robots[i]))
            @test !in(name(robots[i]), history)
        end

        push!(history, name(robots[i]))
    end

    @testset "fresh names of reset robots are valid and unique in history" begin
        Random.seed!()
        for r in robots
            reset!(r)
            @test isname(name(r))
            @test !in(name(r), history)
            push!(history, name(r))
        end
    end
end
