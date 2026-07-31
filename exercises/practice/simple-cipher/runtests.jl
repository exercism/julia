# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/simple-cipher/canonical-data.json
# File last updated on 2026-07-31

using Test

include("simple-cipher.jl")

@testset verbose = true "tests" begin
    @testset "Random key cipher" begin
        @testset "Can encode" begin
            key = generate_key()
            @test encode("aaaaaaaaaa", key) == key[1:10]
        end

        @testset "Can decode" begin
            key = generate_key()
            @test decode(key[1:10], key) == "aaaaaaaaaa"
        end

        @testset "Is reversible. I.e., if you apply decode in a encoded result, you must see the same plaintext encode parameter as a result of the decode method" begin
            key = generate_key()
            @test decode(encode("abcdefghij", key), key) == "abcdefghij"
        end

        @testset "Key is made only of lowercase letters" begin
            key = generate_key()
            @test occursin(r"^[a-z]+$", key)
        end

        @testset "Is reversible. I.e., if you apply decode in a encoded result, you must see the same plaintext encode parameter as a result of the decode method" begin
            @test decode(encode("abcdefghij", "abcdefghij"), "abcdefghij") == "abcdefghij"
        end
    end

    @testset "Substitution cipher" begin
        @testset "Can encode" begin
            @test encode("aaaaaaaaaa", "abcdefghij") == "abcdefghij"
        end

        @testset "Can decode" begin
            @test decode("abcdefghij", "abcdefghij") == "aaaaaaaaaa"
        end

        @testset "Can double shift encode" begin
            @test encode("iamapandabear", "iamapandabear") == "qayaeaagaciai"
        end

        @testset "Can wrap on encode" begin
            @test encode("zzzzzzzzzz", "abcdefghij") == "zabcdefghi"
        end

        @testset "Can wrap on decode" begin
            @test decode("zabcdefghi", "abcdefghij") == "zzzzzzzzzz"
        end

        @testset "Can encode messages longer than the key" begin
            @test encode("iamapandabear", "abc") == "iboaqcnecbfcr"
        end

        @testset "Can decode messages longer than the key" begin
            @test decode("iboaqcnecbfcr", "abc") == "iamapandabear"
        end

        @testset "Is reversible. I.e., if you apply decode in a encoded result, you must see the same plaintext encode parameter as a result of the decode method" begin
            @test decode(encode("abcdefghij", "abcdefghij"), "abcdefghij") == "abcdefghij"
        end
    end
end
