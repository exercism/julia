# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/collatz-conjecture/canonical-data.json
# File last updated on 2026-10-23

using Test

include("collatz-conjecture.jl")

@testset verbose = true "tests" begin
    @testset "zero steps for one" begin
        @test collatz_steps(1) == 0
    end

    @testset "divide if even" begin
        @test collatz_steps(16) == 4
    end

    @testset "even and odd steps" begin
        @test collatz_steps(12) == 9
    end

    @testset "large number of even and odd steps" begin
        @test collatz_steps(1000000) == 152
    end

    @testset "zero is an error" begin
        @test_throws DomainError collatz_steps(0)
    end

    @testset "negative value is an error" begin
        @test_throws DomainError collatz_steps(-15)
    end
end
