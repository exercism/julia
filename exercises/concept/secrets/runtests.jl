using Test

include("secrets.jl")

@testset verbose = true "tests" begin

    @testset "1. Shift back the bits" begin
        @test shift_back(8, 2) == 2

        # The original Java code uses a signed integer, so we use Int32 here
        # Fails with Int64!
        @test shift_back(Int32(-2_144_333_657), 3) == 268_829_204
    end

    @testset "2. Set bits" begin
        @test set_bits(5, 3) == 7
        @test set_bits(5_652, 26_150) == 30_262
    end

    @testset "3. Flip bits" begin
        @test flip_bits(5, 11) == 14
        @test flip_bits(38_460, 15_471) == 43_603
    end

    @testset "4. Clear bits" begin
        @test clear_bits(5, 11) == 4
        @test clear_bits(90, 240) == 10
    end

end
