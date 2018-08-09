using Test

include("trinary.jl")

@testset "trinary 1 is decimal 1" begin
    @test trinary_to_decimal("1") == 1
end

@testset "trinary 2 is decimal 2" begin
    @test trinary_to_decimal("2") == 2
end

@testset "trinary 10 is decimal 3" begin
    @test trinary_to_decimal("10") == 3
end

@testset "trinary 11 is decimal 4" begin
    @test trinary_to_decimal("11") == 4
end

@testset "trinary 100 is decimal 9" begin
    @test trinary_to_decimal("100") == 9
end

@testset "trinary 112 is decimal 14" begin
    @test trinary_to_decimal("112") == 14
end

@testset "trinary 222 is decimal 26" begin
    @test trinary_to_decimal("222") == 26
end

@testset "trinary 1122000120 is decimal 32091" begin
    @test trinary_to_decimal("1122000120") == 32091
end

@testset "invalid trinary digits returns 0" begin
    @test trinary_to_decimal("1234") == 0
end

@testset "invalid word as input returns 0" begin
    @test trinary_to_decimal("carrot") == 0
end

@testset "invalid numbers with letters as input returns 0" begin
    @test trinary_to_decimal("0a1b2c") == 0
end
