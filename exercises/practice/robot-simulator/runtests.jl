using Test

include("robot-simulator.jl")

@testset "constructor" begin
    r = Robot((0, 0), NORTH)
    @test position(r) == Point(0, 0)
    @test heading(r) == NORTH

    r = Robot((-1, -1), SOUTH)
    @test position(r) == Point(-1, -1)
    @test heading(r) == SOUTH
end

@testset "mutating functions should return robot" begin
    r = Robot((0, 0), NORTH)
    @test r == turn_right!(r)
    @test r == turn_left!(r)
    @test r == advance!(r)
    @test r == move!(r, "A")
end

@testset "rotate +π/2" begin
    r = Robot((0, 0), NORTH)
    turn_right!(r)
    @test position(r) == Point(0, 0)
    @test heading(r) == EAST
    turn_right!(r)
    @test heading(r) == SOUTH
    turn_right!(r)
    @test heading(r) == WEST
    turn_right!(r)
    @test heading(r) == NORTH
end

@testset "rotate -π/2" begin
    r = Robot((0, 0), NORTH)
    turn_left!(r)
    @test position(r) == Point(0, 0)
    @test heading(r) == WEST
    turn_left!(r)
    @test heading(r) == SOUTH
    turn_left!(r)
    @test heading(r) == EAST
    turn_left!(r)
    @test heading(r) == NORTH
end

@testset "advance" begin
    r = Robot((0, 0), NORTH)
    advance!(r)
    @test heading(r) == NORTH
    @test position(r) == Point(0, 1)

    @test position(advance!(Robot((0, 0), SOUTH))) == Point(0, -1)
    @test position(advance!(Robot((0, 0), EAST))) == Point(1, 0)
    @test position(advance!(Robot((0, 0), WEST))) == Point(-1, 0)
end

@testset "instructions" begin
    @testset "moving east and north from README" begin
        r = Robot((7, 3), NORTH)
        move!(r, "RAALAL")
        @test position(r) == Point(9, 4)
        @test heading(r) == WEST
    end

    @testset "move west and north" begin
        r = Robot((0, 0), NORTH)
        move!(r, "LAAARALA")
        @test position(r) == Point(-4, 1)
        @test heading(r) == WEST
    end

    @testset "move west and south" begin
        r = Robot((2, -7), EAST)
        move!(r, "RRAAAAALA")
        @test position(r) == Point(-3, -8)
        @test heading(r) == SOUTH
    end

    @testset "move east and north" begin
        r = Robot((8, 4), SOUTH)
        move!(r, "LAAARRRALLLL")
        @test position(r) == Point(11, 5)
        @test heading(r) == NORTH
    end
end
