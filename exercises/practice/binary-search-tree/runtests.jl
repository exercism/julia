using Test

include("binary-search-tree.jl")

@testset verbose = true "tests" begin
    @testset "instantiation with different inputs" begin
        @testset "instantiation without input" begin
            tree = BinarySearchTree()
            @test isa(tree, BinarySearchTree)
        end

        @testset "instantiation with a single real number" begin
            tree = BinarySearchTree(4)
            @test isa(tree, BinarySearchTree)
            @test nodedata(tree) == 4
                @test isnothing(leftnode(tree))
                @test isnothing(rightnode(tree))
        end

        @testset "instantiation with vector containing a single real number" begin
            tree = BinarySearchTree([4])
            @test isa(tree, BinarySearchTree)
            @test nodedata(tree) == 4
                @test isnothing(leftnode(tree))
                @test isnothing(rightnode(tree))
        end

        @testset "instantiation with vector containing multiple real numbers" begin
            tree = BinarySearchTree([4, 3, 5])
            @test isa(tree, BinarySearchTree)
            @test nodedata(tree) == 4
                @test nodedata(leftnode(tree)) == 3
                    @test isnothing(leftnode(leftnode(tree)))
                    @test isnothing(rightnode(leftnode(tree)))
                @test nodedata(rightnode(tree)) == 5
                    @test isnothing(leftnode(rightnode(tree)))
                    @test isnothing(rightnode(rightnode(tree)))
        end
    end

    @testset "searching" begin
        @testset "Single element" begin
            tree = BinarySearchTree([4])
            @test 4 ∈ tree
            @test 5 ∉ tree
        end

        @testset "two elements" begin
            tree = BinarySearchTree([4, 2])
            @test 4 ∈ tree
            @test 2 ∈ tree

            tree = BinarySearchTree([4, 5])
            @test 4 ∈ tree
            @test 5 ∈ tree
        end

        @testset "complex tree" begin
            tree = BinarySearchTree([4, 2, 6, 1, 3, 5, 7])
            @test 4 ∈ tree
            @test 2 ∈ tree
            @test 6 ∈ tree
            @test 1 ∈ tree
            @test 3 ∈ tree
            @test 5 ∈ tree
            @test 7 ∈ tree
        end
    end

    @testset "insert data at proper node" begin
        @testset "smaller number at left node" begin
            tree = BinarySearchTree([4])
            push!(tree, 2)
            @test nodedata(tree) == 4
                @test nodedata(leftnode(tree)) == 2
                    @test isnothing(leftnode(leftnode(tree)))
                    @test isnothing(rightnode(leftnode(tree)))
                @test isnothing(rightnode(tree))
        end

        @testset "same number at left node" begin
            tree = BinarySearchTree([4])
            push!(tree, 4)
            @test nodedata(tree) == 4
                @test nodedata(leftnode(tree)) == 4
                    @test isnothing(leftnode(leftnode(tree)))
                    @test isnothing(rightnode(leftnode(tree)))
                @test isnothing(rightnode(tree))
        end
        
        @testset "greater number at right node" begin
            tree = BinarySearchTree([4])
            push!(tree, 5)
            @test nodedata(tree) == 4
                @test isnothing(leftnode(tree))
                @test nodedata(rightnode(tree)) == 5
                    @test isnothing(leftnode(rightnode(tree)))
                    @test isnothing(rightnode(rightnode(tree)))
        end
    end

    @testset "can create complex tree" begin
        tree = BinarySearchTree([4])
        foreach(node -> push!(tree, node), [2, 6, 1, 3, 5, 7])
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
            tree = BinarySearchTree([4, 2, 6, 1, 3, 5, 7])
            @test sort(tree) == [1, 2, 3, 4, 5, 6, 7]
        end
    end
end
