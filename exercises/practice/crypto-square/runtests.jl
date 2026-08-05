# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/crypto-square/canonical-data.json
# File last updated on 2026-08-05

using Test

include("crypto-square.jl")

@testset verbose = true "tests" begin
    @testset "empty plaintext results in an empty ciphertext" begin
        @test ciphertext("") == ""
    end

    @testset "normalization results in empty plaintext" begin
        @test ciphertext("... --- ...") == ""
    end

    @testset "Lowercase" begin
        @test ciphertext("A") == "a"
    end

    @testset "Remove spaces" begin
        @test ciphertext("  b ") == "b"
    end

    @testset "Remove punctuation" begin
        @test ciphertext("@1,%!") == "1"
    end

    @testset "9 character plaintext results in 3 chunks of 3 characters" begin
        @test ciphertext("This is fun!") == "tsf hiu isn"
    end

    @testset "8 character plaintext results in 3 chunks, the last one with a trailing space" begin
        @test ciphertext("Chill out.") == "clu hlt io "
    end

    @testset "54 character plaintext results in 8 chunks, the last two with trailing spaces" begin
        @test ciphertext("If man was meant to stay on the ground, god would have given us roots.") ==
              "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau "
    end
end
