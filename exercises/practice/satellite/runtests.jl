using Test

include("satellite.jl")

@testset verbose = true "tests" begin
    @testset "Empty tree" begin
        preorder = String[]
        inorder = String[]
        @test isnothing(tree_from_traversals(preorder, inorder))
    end

    @testset "Tree with one item" begin
        preorder = ["a"]
        inorder = ["a"]
        expected = Tree("a", nothing, nothing)
        @test tree_from_traversals(preorder, inorder) == expected
    end

    @testset "Tree with many items" begin
        preorder = ["a", "i", "x", "f", "r"]
        inorder = ["i", "a", "f", "x", "r"]
        expected = Tree("a", 
                        Tree("i", nothing, nothing), 
                        Tree("x", 
                              Tree("f", nothing, nothing), 
                              Tree("r", nothing, nothing)))
        @test tree_from_traversals(preorder, inorder) == expected
    end

    @testset "A degenerate binary tree" begin
        preorder = ["a", "b", "c", "d"]
        inorder = ["d", "c", "b", "a"]
        expected = Tree("a", 
                        Tree("b", 
                              Tree("c",
                                    Tree("d", nothing, nothing), 
                                    nothing), 
                              nothing), 
                        nothing)
        @test tree_from_traversals(preorder, inorder) == expected
    end

    @testset "Another degenerate binary tree" begin
        preorder = ["a", "b", "c", "d"]
        inorder = ["a", "b", "c", "d"]
        expected = Tree("a",
                        nothing,
                        Tree("b",
                              nothing,
                              Tree("c",
                                    nothing,
                                    Tree("d", nothing, nothing))))
        @test tree_from_traversals(preorder, inorder) == expected
    end

    @testset "Tree with many more items" begin
        preorder = ["a", "b", "d", "g", "h", "c", "e", "f", "i"]
        inorder = ["g", "d", "h", "b", "a", "e", "c", "i", "f"]
        expected = Tree("a",
                        Tree("b",
                              Tree("d",
                                    Tree("g", nothing, nothing),
                                    Tree("h", nothing, nothing)),
                              nothing),
                        Tree("c",
                              Tree("e", nothing, nothing),
                              Tree("f",
                                    Tree("i", nothing, nothing),
                                    nothing)))
        @test tree_from_traversals(preorder, inorder) == expected
    end


    @testset "Reject traversals of different length" begin
        preorder = ["a", "b"]
        inorder = ["b", "a", "r"]
         @test_throws ArgumentError tree_from_traversals(preorder, inorder)
    end

    @testset "Reject inconsistent traversals of same length" begin
        preorder = ["x", "y", "z"]
        inorder = ["b", "a", "r"]
        @test_throws ArgumentError tree_from_traversals(preorder, inorder)
    end

    @testset "Reject traversals with repeated items" begin
        preorder = ["a", "b", "a"]
        inorder = ["b", "a", "a"]
        @test_throws ArgumentError tree_from_traversals(preorder, inorder)
    end

end
