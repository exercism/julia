using Test

include("matrix.jl")

@testset verbose = true "tests" begin
    @testset "extract row from one number matrix" begin
        rows, columns = matrix("1")
        @test rows[1] == [1]
     end

     @testset "can extract row" begin
        rows, columns = matrix("1 2\n3 4")
        @test rows[2] == [3, 4]
     end

     @testset "extract row where numbers have different widths" begin
        rows, columns = matrix("1 2\n10 20")
        @test rows[2] == [10, 20]
     end

     @testset "can extract row from non-square matrix with no corresponding column" begin
        rows, columns = matrix("1 2 3\n4 5 6\n7 8 9\n8 7 6")
        @test rows[4] == [8, 7, 6]
     end

     @testset "extract column from one number matrix" begin
        rows, columns = matrix("1") 
        @test columns[1] == [1]
     end

     @testset "can extract column" begin
        rows, columns = matrix("1 2 3\n4 5 6\n7 8 9")
        @test columns[3] == [3, 6, 9]
     end

     @testset "can extract column from non-square matrix with no corresponding row" begin
        rows, columns = matrix("1 2 3 4\n5 6 7 8\n9 8 7 6")
        @test columns[4] == [4, 8, 6]
     end

     @testset "extract column where numbers have different widths" begin
        rows, columns = matrix("89 1903 3\n18 3 1\n9 4 800")
        @test columns[2] == [1903, 3, 4]
     end
end
