# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/strain/canonical-data.json
# File last updated on 2026-10-25

using Test

include("strain.jl")

@testset verbose = true "tests" begin
    @testset "keep on empty list returns empty list" begin
        @test keep(Int[], x -> true) == []
    end

    @testset "keeps everything" begin
        @test keep([1, 3, 5], x -> true) == [1, 3, 5]
    end

    @testset "keeps nothing" begin
        @test keep([1, 3, 5], x -> false) == []
    end

    @testset "keeps first and last" begin
        @test keep([1, 2, 3], x -> x % 2 == 1) == [1, 3]
    end

    @testset "keeps neither first nor last" begin
        @test keep([1, 2, 3], x -> x % 2 == 0) == [2]
    end

    @testset "keeps strings" begin
        @test keep(["apple", "zebra", "banana", "zombies", "cherimoya", "zealot"],
                   x -> startswith(x, 'z')) == ["zebra", "zombies", "zealot"]
    end

    @testset "keeps lists" begin
        @test keep([[1, 2, 3], [5, 5, 5], [5, 1, 2], [2, 1, 2], [1, 5, 2], [2, 2, 1],
                    [1, 2, 5]], x -> 5 in x) == [[5, 5, 5], [5, 1, 2], [1, 5, 2], [1, 2, 5]]
    end

    @testset "discard on empty list returns empty list" begin
        @test discard(Int[], x -> true) == []
    end

    @testset "discards everything" begin
        @test discard([1, 3, 5], x -> true) == []
    end

    @testset "discards nothing" begin
        @test discard([1, 3, 5], x -> false) == [1, 3, 5]
    end

    @testset "discards first and last" begin
        @test discard([1, 2, 3], x -> x % 2 == 1) == [2]
    end

    @testset "discards neither first nor last" begin
        @test discard([1, 2, 3], x -> x % 2 == 0) == [1, 3]
    end

    @testset "discards strings" begin
        @test discard(["apple", "zebra", "banana", "zombies", "cherimoya", "zealot"],
                      x -> startswith(x, 'z')) == ["apple", "banana", "cherimoya"]
    end

    @testset "discards lists" begin
        @test discard([[1, 2, 3], [5, 5, 5], [5, 1, 2], [2, 1, 2], [1, 5, 2], [2, 2, 1],
                       [1, 2, 5]], x -> 5 in x) == [[1, 2, 3], [2, 1, 2], [2, 2, 1]]
    end
end
