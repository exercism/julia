using Test
include("binary-search-tree.jl")

@testset "data is retained" begin
    tree = BinarySearchTree([4])
    @test tree.data == 4
        @test isnothing(tree.left)
        @test isnothing(tree.right)
end

@testset "insert data at proper node" begin
    @testset "smaller number at left node" begin
        tree = BinarySearchTree([4, 2])
        @test tree.data == 4
            @test tree.left.data == 2
                @test isnothing(tree.left.left)
                @test isnothing(tree.left.right)
            @test isnothing(tree.right)
    end

    @testset "same number at left node" begin
        tree = BinarySearchTree([4, 4])
        @test tree.data == 4
            @test tree.left.data == 4
                @test isnothing(tree.left.left)
                @test isnothing(tree.left.right)
            @test isnothing(tree.right)
    end
    
    @testset "greater number at right node" begin
        tree = BinarySearchTree([4, 5])
        @test tree.data == 4
            @test isnothing(tree.left)
            @test tree.right.data == 5
                @test isnothing(tree.right.left)
                @test isnothing(tree.right.right)
    end
end

@testset "can create complex tree" begin
    tree = BinarySearchTree([4, 2, 6, 1, 3, 5, 7])
    @test tree.data == 4
        @test tree.left.data == 2
            @test tree.left.left.data == 1
                @test isnothing(tree.left.left.left)
                @test isnothing(tree.left.left.right)
            @test tree.left.right.data == 3
                @test isnothing(tree.left.right.left)
                @test isnothing(tree.left.right.right)
        @test tree.right.data == 6
            @test tree.right.left.data == 5
                @test isnothing(tree.right.left.left)
                @test isnothing(tree.right.left.right)
            @test tree.right.right.data == 7
                @test isnothing(tree.right.right.left)
                @test isnothing(tree.right.right.right)    

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
        tree = BinarySearchTree([4, 2, 6, 1, 3, 5, 7])
        @test sort(tree) == [1, 2, 3, 4, 5, 6, 7]
    end
end
