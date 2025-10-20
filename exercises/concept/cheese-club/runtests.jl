using Test

include("cheese-club.jl")

@testset verbose = true "tests" begin
    @testset "1. classify customers" begin
        @test all_15([2, 3, 4, 4, 1]) == false
        @test all_15([5, 1, 5, 1, 5, 4, 2, 3, 1, 5, 4, 4, 2, 3]) == false

        @test all_15([1, 5, 5, 1, 5]) == true
        @test all_15([5, 1, 5, 1, 5, 5, 1, 1, 1, 5, 5, 5, 1, 5]) == true
    end

    @testset "2. separate out emphatic customers" begin
        customers = Dict(zip(("c1", "c2", "c3", "c4"),([2, 3, 5, 1, 1], [1, 1, 5, 5, 1], [4, 5, 5, 3, 2], [5, 5, 1, 1, 5])))
        @test emphatics(customers) == Dict(zip(("c2", "c4"),([1, 1, 5, 5, 1], [5, 5, 1, 1, 5])))

        customers = Dict(zip(("c1", "c2"), ([1, 5, 5], [5, 1, 1], [1, 5, 1])))
        @test emphatics(customers) == Dict(zip(("c1", "c2"), ([1, 5, 5], [5, 1, 1], [1, 5, 1])))

        customers = Dict(zip(("c1", "c2"), ([1, 2, 5], [3, 1, 4], [4, 2, 1])))
        @test emphatics(customers) == Dict{String, Int}()
    end

    @testset "3. change ratings to binary" begin
        @test tobinary([1, 1, 5, 5, 1]) == [0, 0, 1, 1, 0]
        @test tobinary([5, 1, 5, 1, 5, 5, 1, 1, 1, 5, 5, 5, 1, 5]) == [1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 1]
    end

    @testset "4. make ratings into a matrix" begin
        ratings = [[1, 1, 5, 5, 1], [5, 5, 1, 1, 5]]
        @test tobinarymatrix(ratings) == [0 0 1 1 0; 1 1 0 0 1]

        ratings = [[1, 5, 1], [5, 5, 1], [5, 5, 5]]
        @test tobinarymatrix(ratings) == [0 1 0; 1 1 0; 1 1 1]

        ratings = [[1, 5, 1], [5, 5, 1], [5, 5, 5], [1, 1, 5], [1, 1, 1]]
        @test tobinarymatrix(ratings) == [0 1 0; 1 1 0; 1 1 1; 0 0 1; 0 0 0]
    end
end
