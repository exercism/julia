using Test

include("largest-series-product.jl")

@testset verbose = true "tests" begin
    @testset "finds the largest product if span equals length" begin
        @test largest_product("29", 2) == 18
    end

    @testset "can find the largest product of 2 with numbers in order" begin
        @test largest_product("0123456789", 2) == 72
    end

    @testset "can find the largest product of 2" begin
        @test largest_product("576802143", 2) == 48
    end

    @testset "can find the largest product of 3 with numbers in order" begin
        @test largest_product("0123456789", 3) == 504
    end

    @testset "can find the largest product of 3" begin
        @test largest_product("1027839564", 3) == 270
    end

    @testset "can find the largest product of 5 with numbers in order" begin
        @test largest_product("0123456789", 5) == 15_120
    end

    @testset "can get the largest product of a big number" begin
        @test largest_product("73167176531330624919225119674426574742355349194934", 6) == 23_520
    end

    @testset "reports zero if the only digits are zero" begin
        @test largest_product("0000", 2) == 0
    end

    @testset "reports zero if all spans include zero" begin
        @test largest_product("99099", 3) == 0
    end

    @testset "error handling" begin
        @testset "span longer than string length" begin
            @test_throws ArgumentError largest_product("123", 4)
        end

        @testset "empty string and nonzero span" begin
            @test_throws ArgumentError largest_product("", 1)
        end

        @testset "invalid character in digits" begin
            @test_throws ArgumentError largest_product("1234a5", 2)
        end

        @testset "negative span" begin
            @test_throws ArgumentError largest_product("12345", -1)
        end
    end
end
