# canonical data version: 1.2.0

using Test

include("binary-search.jl")

@testset "default binary search" begin
    @testset "value in array" begin
        @test binarysearch([6], 6) == 1:1
        @test binarysearch([1, 3, 4, 6, 8, 9, 11], 6) == 4:4
        @test binarysearch([1, 3, 4, 6, 8, 9, 11], 1) == 1:1
        @test binarysearch([1, 3, 4, 6, 8, 9, 11], 11) == 7:7
        @test binarysearch([1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 634], 144) == 10:10
        @test binarysearch([1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377], 21) == 6:6
    end
    @testset "value not in array" begin
        @test binarysearch([1, 3, 4, 6, 8, 9, 11], 7) == 5:4
        @test binarysearch([1, 3, 4, 6, 8, 9, 11], 0) == 1:0
        @test binarysearch([1, 3, 4, 6, 8, 9, 11], 13) == 8:7
        @test binarysearch([], 1) == 1:0
    end
end
