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
        @test !luhn("055 444 286")
    end

    @testset "invalid credit card" begin
        @test !luhn("8273 1232 7352 0569")
    end

    @testset "valid strings with a non-digit added become invalid" begin
        @test !luhn("046a 454 286")
    end

    @testset "invalid long number with an even remainder" begin
        @test !luhn("1 2345 6789 1234 5678 9012")
    end

    @testset "valid strings with a non-digit added at the end become invalid" begin
        @test !luhn("059a")
    end

    @testset "valid strings with punctuation included become invalid" begin
        @test !luhn("055-444-285")
    end

    @testset "valid strings with symbols included become invalid" begin
        @test !luhn("055# 444\$ 285")
    end

    @testset "single zero with space is invalid" begin
        @test !luhn(" 0")
    end

    @testset "using ascii value for non-doubled non-digit isn't allowed" begin
        @test !luhn("055b 444 285")
    end

    @testset "using ascii value for doubled non-digit isn't allowed" begin
        @test !luhn(":9")
    end
end

@testset "valid" begin
    @testset "valid Canadian SIN" begin
        @test luhn("055 444 285")
    end

    @testset "a simple valid SIN that remains valid if reversed" begin
        @test luhn("059")
    end

    @testset "a simple valid SIN that becomes invalid if reversed" begin
        @test luhn("59")
    end

    @testset "valid number with an even number of digits" begin
        @test luhn("095 245 88")
    end

    @testset "valid number with an odd number of spaces" begin
        @test luhn("234 567 891 234")
    end

    @testset "more than a single zero is valid" begin
        @test luhn("0000 0")
    end

    @testset "input digit 9 is correctly converted to output digit 9" begin
        @test luhn("091")
    end
end
