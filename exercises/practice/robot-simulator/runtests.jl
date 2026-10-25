# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/robot-simulator/canonical-data.json
# File last updated on 2026-10-25

using Test

include("robot-simulator.jl")

@testset verbose = true "tests" begin
    @testset "Create robot" begin
        @testset "at origin facing north" begin
            r = Robot((0, 0), NORTH)
            @test position(r) == Point(0, 0)
            @test heading(r) == NORTH
        end

        @testset "at negative position facing south" begin
            r = Robot((-1, -1), SOUTH)
            @test position(r) == Point(-1, -1)
            @test heading(r) == SOUTH
        end
    end

    @testset "Rotating clockwise" begin
        @testset "changes north to east" begin
            r = Robot((0, 0), NORTH)
            move!(r, "R")
            @test position(r) == Point(0, 0)
            @test heading(r) == EAST
        end

        @testset "changes east to south" begin
            r = Robot((0, 0), EAST)
            move!(r, "R")
            @test position(r) == Point(0, 0)
            @test heading(r) == SOUTH
        end

        @testset "changes south to west" begin
            r = Robot((0, 0), SOUTH)
            move!(r, "R")
            @test position(r) == Point(0, 0)
            @test heading(r) == WEST
        end

        @testset "changes west to north" begin
            r = Robot((0, 0), WEST)
            move!(r, "R")
            @test position(r) == Point(0, 0)
            @test heading(r) == NORTH
        end
    end

    @testset "Rotating counter-clockwise" begin
        @testset "changes north to west" begin
            r = Robot((0, 0), NORTH)
            move!(r, "L")
            @test position(r) == Point(0, 0)
            @test heading(r) == WEST
        end

        @testset "changes west to south" begin
            r = Robot((0, 0), WEST)
            move!(r, "L")
            @test position(r) == Point(0, 0)
            @test heading(r) == SOUTH
        end

        @testset "changes south to east" begin
            r = Robot((0, 0), SOUTH)
            move!(r, "L")
            @test position(r) == Point(0, 0)
            @test heading(r) == EAST
        end

        @testset "changes east to north" begin
            r = Robot((0, 0), EAST)
            move!(r, "L")
            @test position(r) == Point(0, 0)
            @test heading(r) == NORTH
        end
    end

    @testset "Moving forward one" begin
        @testset "facing north increments Y" begin
            r = Robot((0, 0), NORTH)
            move!(r, "A")
            @test position(r) == Point(0, 1)
            @test heading(r) == NORTH
        end

        @testset "facing south decrements Y" begin
            r = Robot((0, 0), SOUTH)
            move!(r, "A")
            @test position(r) == Point(0, -1)
            @test heading(r) == SOUTH
        end

        @testset "facing east increments X" begin
            r = Robot((0, 0), EAST)
            move!(r, "A")
            @test position(r) == Point(1, 0)
            @test heading(r) == EAST
        end

        @testset "facing west decrements X" begin
            r = Robot((0, 0), WEST)
            move!(r, "A")
            @test position(r) == Point(-1, 0)
            @test heading(r) == WEST
        end
    end

    @testset "Follow series of instructions" begin
        @testset "moving east and north from README" begin
            r = Robot((7, 3), NORTH)
            move!(r, "RAALAL")
            @test position(r) == Point(9, 4)
            @test heading(r) == WEST
        end

        @testset "moving west and north" begin
            r = Robot((0, 0), NORTH)
            move!(r, "LAAARALA")
            @test position(r) == Point(-4, 1)
            @test heading(r) == WEST
        end

        @testset "moving west and south" begin
            r = Robot((2, -7), EAST)
            move!(r, "RRAAAAALA")
            @test position(r) == Point(-3, -8)
            @test heading(r) == SOUTH
        end

        @testset "moving east and north" begin
            r = Robot((8, 4), SOUTH)
            move!(r, "LAAARRRALLLL")
            @test position(r) == Point(11, 5)
            @test heading(r) == NORTH
        end
    end
end
