# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/run-length-encoding/canonical-data.json
# File last updated on 2026-10-24

using Test

include("run-length-encoding.jl")

@testset verbose = true "tests" begin
    @testset "run-length encode a string" begin
        @testset "empty string" begin
            @test encode("") == ""
        end

        @testset "single characters only are encoded without count" begin
            @test encode("XYZ") == "XYZ"
        end

        @testset "string with no single characters" begin
            @test encode("AABBBCCCC") == "2A3B4C"
        end

        @testset "single characters mixed with repeated characters" begin
            @test encode("WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB") ==
                  "12WB12W3B24WB"
        end

        @testset "multiple whitespace mixed in string" begin
            @test encode("  hsqq qww  ") == "2 hs2q q2w2 "
        end

        @testset "lowercase characters" begin
            @test encode("aabbbcccc") == "2a3b4c"
        end
    end

    @testset "run-length decode a string" begin
        @testset "empty string" begin
            @test decode("") == ""
        end

        @testset "single characters only" begin
            @test decode("XYZ") == "XYZ"
        end

        @testset "string with no single characters" begin
            @test decode("2A3B4C") == "AABBBCCCC"
        end

        @testset "single characters with repeated characters" begin
            @test decode("12WB12W3B24WB") ==
                  "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"
        end

        @testset "multiple whitespace mixed in string" begin
            @test decode("2 hs2q q2w2 ") == "  hsqq qww  "
        end

        @testset "lowercase string" begin
            @test decode("2a3b4c") == "aabbbcccc"
        end
    end

    @testset "encode and then decode" begin
        @testset "encode followed by decode gives original string" begin
            @test decode(encode("zzz ZZ  zZ")) == "zzz ZZ  zZ"
        end
    end
end
