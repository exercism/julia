using Test

include("robot-name.jl")

# Random names means a risk of collisions.
history = String[]

isname(x) = occursin(r"^[A-Z]{2}[0-9]{3}$", x)

@testset "one robot" begin
    global r1 = Robot()
    push!(history, r1.name)

    @testset "name of robot is valid" begin
        @test isname(r1.name)
    end

    @testset "names of robot instance are valid and unique in history" begin
        for i in 1:100
            reset!(r1)
            @test isname(r1.name)
            @test !in(r1.name, history)
            push!(history, r1.name)
        end
    end
end

@testset "two robots" begin
    global r2 = Robot()
    global r3 = Robot()

    @testset "names of robots are valid" begin
        @test isname(r2.name)
        @test isname(r3.name)
    end
    
    @testset "names of robots are not equal" begin
        @test r2.name != r3.name
    end

    @testset "names of both robots are unique in history" begin
        @test !in(r2.name, history)
        @test !in(r3.name, history)
    end

    push!(history, r2.name)
    push!(history, r3.name)
end

@testset "many robots" begin
    global robots = Robot[]

    for i in 1:10
        push!(robots, Robot())

        @testset "name of robot is valid and unique in history" begin
            @test isname(robots[i].name)
            @test !in(robots[i].name, history)
        end

        push!(history, robots[i].name)
    end

    @testset "fresh names of reset robots are valid and unique in history" begin
        for r in robots
            reset!(r)
            @test isname(r.name)
            @test !in(r.name, history)
            push!(history, r.name)
        end
    end
end
