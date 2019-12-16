# canonical data version: 1.1.0

 using Test

 include("accumulate.jl")

 @testset "multiply" begin
     @test accumulate(collect(1:10), *) == [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
 end

 @testset "divide" begin
     @test accumulate(collect(1:10), /) == [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]
 end

 @testset "subtract" begin
     @test accumulate(collect(1:10), -) == [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
 end

 @testset "add" begin
     @test accumulate(collect(1:10), +) == [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
 end

 @testset "mod" begin
     @test accumulate(collect(1:10), %) == [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
 end
