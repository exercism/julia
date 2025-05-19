using Test

include("grading-guru.jl")

@testset verbose = true "tests" begin
    @testset "1. Demote" begin
        @testset "Floats" begin
            @test demote(4.6) === UInt8(5)
            @test demote(6.2) === UInt8(7)
            @test demote(2.0) === UInt8(2)
        end

        @testset "Integers" begin
            @test demote(4) === Int8(4)
            @test demote(Int16(2)) === Int8(2)
            @test demote(Int32(-1)) === Int8(-1)
        end

        @testset "Invalid Inputs" begin
            @test_throws MethodError demote(Float32(4.2))
            @test_throws MethodError demote("42")
            @test_throws MethodError demote(21+42im)
            @test_throws MethodError demote([2, 4, 5])
            @test_throws MethodError demote(Set([2, 4, 5]))
        end
    end

    @testset "2. Preprocess" begin
        @testset "Vectors" begin
            @test preprocess([2, 4, 5])::Vector{Int8} == Int8[5, 4, 2]
            @test preprocess([2, 4, 5])::Vector{Int8} == Int8[5, 4, 2]
            @test preprocess([UInt16(2), Int32(4), big(5)])::Vector{Int8} == Int8[5, 4, 2]
            @test preprocess([4, 5, 7, 8, 9])::Vector{Int8} == Int8[9, 8, 7, 5, 4]
            @test preprocess([2, 5, 4])::Vector{Int8} == Int8[4, 5, 2]
        end

        @testset "Sets" begin
            @test preprocess(Set([2, 4, 5]))::Vector{Int8} == Int8[5, 4, 2]
            @test preprocess(Set([UInt16(2), Int32(4), big(5)]))::Vector{Int8} == Int8[5, 4, 2]
            @test preprocess(Set([8, 5, 7, 4, 9]))::Vector{Int8} == Int8[9, 8, 7, 5, 4]
            @test preprocess(Set([4.3, 7.6, 1.2]))::Vector{UInt8} == UInt8[8, 5, 2]
        end

        @testset "Invalid Inputs" begin
            @test_throws MethodError preprocess(42)
            @test_throws MethodError preprocess(42.0)
            @test_throws MethodError preprocess("42")
            @test_throws MethodError preprocess(1-4im)
            @test_throws MethodError preprocess(π)
        end
    end
end
