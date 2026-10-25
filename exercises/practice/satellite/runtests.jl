# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/satellite/canonical-data.json
# File last updated on 2026-10-25

using Test

include("satellite.jl")

@testset verbose = true "tests" begin
    @testset "Empty tree" begin
        @test isnothing(tree_from_traversals(String[], String[]))
    end

    @testset "Tree with one item" begin
        @test tree_from_traversals(["a"], ["a"]) == Tree("a", nothing, nothing)
    end

    @testset "Tree with many items" begin
        @test tree_from_traversals(["a", "i", "x", "f", "r"], ["i", "a", "f", "x", "r"]) ==
              Tree("a", Tree("i", nothing, nothing),
                   Tree("x", Tree("f", nothing, nothing), Tree("r", nothing, nothing)))
    end

    @testset "Reject traversals of different length" begin
        @test_throws ArgumentError tree_from_traversals(["a", "b"], ["b", "a", "r"])
    end

    @testset "Reject inconsistent traversals of same length" begin
        @test_throws ArgumentError tree_from_traversals(["x", "y", "z"], ["a", "b", "c"])
    end

    @testset "Reject traversals with repeated items" begin
        @test_throws ArgumentError tree_from_traversals(["a", "b", "a"], ["b", "a", "a"])
    end

    @testset "A degenerate binary tree" begin
        @test tree_from_traversals(["a", "b", "c", "d"], ["d", "c", "b", "a"]) ==
              Tree("a", Tree("b", Tree("c", Tree("d", nothing, nothing), nothing), nothing),
                   nothing)
    end

    @testset "Another degenerate binary tree" begin
        @test tree_from_traversals(["a", "b", "c", "d"], ["a", "b", "c", "d"]) ==
              Tree("a", nothing,
                   Tree("b", nothing, Tree("c", nothing, Tree("d", nothing, nothing))))
    end

    @testset "Tree with many more items" begin
        @test tree_from_traversals(["a", "b", "d", "g", "h", "c", "e", "f", "i"],
                                   ["g", "d", "h", "b", "a", "e", "c", "i", "f"]) ==
              Tree("a",
                   Tree("b",
                        Tree("d", Tree("g", nothing, nothing), Tree("h", nothing, nothing)),
                        nothing),
                   Tree("c", Tree("e", nothing, nothing),
                        Tree("f", Tree("i", nothing, nothing), nothing)))
    end
end
