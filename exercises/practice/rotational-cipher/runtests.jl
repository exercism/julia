# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/rotational-cipher/canonical-data.json
# File last updated on 2026-10-25

using Test

include("rotational-cipher.jl")

@testset verbose = true "tests" begin
    @testset "rotate a by 0, same output as input" begin
        @test rotate(0, "a") == "a"
        @test rotate(0, 'a') == 'a'
    end

    @testset "rotate a by 1" begin
        @test rotate(1, "a") == "b"
        @test rotate(1, 'a') == 'b'
    end

    @testset "rotate a by 26, same output as input" begin
        @test rotate(26, "a") == "a"
        @test rotate(26, 'a') == 'a'
    end

    @testset "rotate m by 13" begin
        @test rotate(13, "m") == "z"
        @test rotate(13, 'm') == 'z'
    end

    @testset "rotate n by 13 with wrap around alphabet" begin
        @test rotate(13, "n") == "a"
        @test rotate(13, 'n') == 'a'
    end

    @testset "rotate capital letters" begin
        @test rotate(5, "OMG") == "TRL"
    end

    @testset "rotate spaces" begin
        @test rotate(5, "O M G") == "T R L"
    end

    @testset "rotate numbers" begin
        @test rotate(4, "Testing 1 2 3 testing") == "Xiwxmrk 1 2 3 xiwxmrk"
    end

    @testset "rotate punctuation" begin
        @test rotate(21, "Let's eat, Grandma!") == "Gzo'n zvo, Bmviyhv!"
    end

    @testset "rotate all letters" begin
        @test rotate(13, "The quick brown fox jumps over the lazy dog.") ==
              "Gur dhvpx oebja sbk whzcf bire gur ynml qbt."
    end

    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    # Bonus tests                                                                 #
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

    # Bonus A
    if isdefined(@__MODULE__, Symbol("@R13_str"))
        @eval @testset "Bonus A: string literal R13" begin
            @test R13"The quick brown fox jumps over the lazy dog." ==
                  "Gur dhvpx oebja sbk whzcf bire gur ynml qbt."
        end
    end

    # Bonus B
    if isdefined(@__MODULE__, Symbol("@R1_str"))
        @eval @testset "Bonus B: string literals" begin
            @test R5"OMG" == "TRL"
            @test R4"Testing 1 2 3 testing" == "Xiwxmrk 1 2 3 xiwxmrk"
            @test R21"Let's eat, Grandma!" == "Gzo'n zvo, Bmviyhv!"
            @test R13"The quick brown fox jumps over the lazy dog." ==
                  "Gur dhvpx oebja sbk whzcf bire gur ynml qbt."
        end
    end
end
