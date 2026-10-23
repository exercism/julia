# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/armstrong-numbers/canonical-data.json
# File last updated on 2026-10-23

using Test

include("armstrong-numbers.jl")

@testset verbose = true "tests" begin
    @testset "Zero is an Armstrong number" begin
        @test isarmstrong(0)
    end

    @testset "Single-digit numbers are Armstrong numbers" begin
        @test isarmstrong(5)
    end

    @testset "There are no two-digit Armstrong numbers" begin
        @test !isarmstrong(10)
    end

    @testset "Three-digit number that is an Armstrong number" begin
        @test isarmstrong(153)
    end

    @testset "Three-digit number that is not an Armstrong number" begin
        @test !isarmstrong(100)
    end

    @testset "Four-digit number that is an Armstrong number" begin
        @test isarmstrong(9474)
    end

    @testset "Four-digit number that is not an Armstrong number" begin
        @test !isarmstrong(9475)
    end

    @testset "Seven-digit number that is an Armstrong number" begin
        @test isarmstrong(9926315)
    end

    @testset "Seven-digit number that is not an Armstrong number" begin
        @test !isarmstrong(9926314)
    end

    # Bonus tasks: enabled by adding `const TEST_BIG_INTEGERS = true` to the solution file
    if isdefined(TEST_BIG_INTEGERS)
        @eval @testset "big_integers" begin
            @testset "Armstrong number containing seven zeroes" begin
                @test isarmstrong(186709961001538790100634132976990)
            end

            @testset "The largest and last Armstrong number" begin
                @test isarmstrong(115132219018763992565095597973971522401)
            end
        end
    end
end
