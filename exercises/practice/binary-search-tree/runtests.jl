# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/binary-search-tree/canonical-data.json
# File last updated on 2026-10-25

using Test

include("binary-search-tree.jl")

@testset verbose = true "tests" begin
    @testset "data is retained" begin
        tree = BinarySearchTree([4])
        @test nodedata(tree) == 4
        @test isnothing(leftnode(tree))
        @test isnothing(rightnode(tree))
    end

    @testset "insert data at proper node" begin
        @testset "smaller number at left node" begin
            tree = BinarySearchTree([4, 2])
            @test nodedata(tree) == 4
            @test nodedata(leftnode(tree)) == 2
            @test isnothing(leftnode(leftnode(tree)))
            @test isnothing(rightnode(leftnode(tree)))
            @test isnothing(rightnode(tree))
        end

        @testset "same number at left node" begin
            tree = BinarySearchTree([4, 4])
            @test nodedata(tree) == 4
            @test nodedata(leftnode(tree)) == 4
            @test isnothing(leftnode(leftnode(tree)))
            @test isnothing(rightnode(leftnode(tree)))
            @test isnothing(rightnode(tree))
        end

        @testset "greater number at right node" begin
            tree = BinarySearchTree([4, 5])
            @test nodedata(tree) == 4
            @test isnothing(leftnode(tree))
            @test nodedata(rightnode(tree)) == 5
            @test isnothing(leftnode(rightnode(tree)))
            @test isnothing(rightnode(rightnode(tree)))
        end
    end

    @testset "can create complex tree" begin
        tree = BinarySearchTree([4, 2, 6, 1, 3, 5, 7])
        @test nodedata(tree) == 4
        @test nodedata(leftnode(tree)) == 2
        @test nodedata(leftnode(leftnode(tree))) == 1
        @test isnothing(leftnode(leftnode(leftnode(tree))))
        @test isnothing(rightnode(leftnode(leftnode(tree))))
        @test nodedata(rightnode(leftnode(tree))) == 3
        @test isnothing(leftnode(rightnode(leftnode(tree))))
        @test isnothing(rightnode(rightnode(leftnode(tree))))
        @test nodedata(rightnode(tree)) == 6
        @test nodedata(leftnode(rightnode(tree))) == 5
        @test isnothing(leftnode(leftnode(rightnode(tree))))
        @test isnothing(rightnode(leftnode(rightnode(tree))))
        @test nodedata(rightnode(rightnode(tree))) == 7
        @test isnothing(leftnode(rightnode(rightnode(tree))))
        @test isnothing(rightnode(rightnode(rightnode(tree))))
    end

    @testset "can sort data" begin
        @testset "can sort single number" begin
            tree = BinarySearchTree([2])
            @test sort(tree) == [2]
        end

        @testset "can sort if second number is smaller than first" begin
            tree = BinarySearchTree([2, 1])
            @test sort(tree) == [1, 2]
        end

        @testset "can sort if second number is same as first" begin
            tree = BinarySearchTree([2, 2])
            @test sort(tree) == [2, 2]
        end

        @testset "can sort if second number is greater than first" begin
            tree = BinarySearchTree([2, 3])
            @test sort(tree) == [2, 3]
        end

        @testset "can sort complex tree" begin
            tree = BinarySearchTree([2, 1, 3, 6, 7, 5])
            @test sort(tree) == [1, 2, 3, 5, 6, 7]
        end
    end
end
