using Test

include("luhn.jl")

@testset "invalid" begin
    @testset "single digit strings can not be valid" begin
        @test !luhn("1")
    end

    @testset "A single zero is invalid" begin
        @test !luhn("0")
    end

    @testset "invalid Canadian SIN" begin
        @test !luhn("046 454 287")
    end

    @testset "invalid credit card" begin
        @test !luhn("8273 1232 7352 0569")
    end

    @testset "valid strings with a non-digit added become invalid" begin
        @test !luhn("046a 454 286")
    end
end

@testset "valid" begin
    @testset "valid Canadian SIN" begin
        @test luhn("046 454 286")
    end
end
