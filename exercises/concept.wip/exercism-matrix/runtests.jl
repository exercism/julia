using Test

include("exercism-matrix.jl")

@testset verbose = true "tests" begin
    @testset "construct E" begin
        @test E == [
            0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0;
            0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
            0 1 0 0 0 1 0 0 0 0 0 0 1 0 0 0 1 0;
            0 1 0 0 1 0 1 0 0 0 0 1 0 1 0 0 1 0;
            0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
            1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
            0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0;
            0 1 0 0 0 0 0 1 0 0 1 0 0 0 0 0 1 0;
            0 1 0 0 0 0 0 0 1 1 0 0 0 0 0 0 1 0;
            0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
            0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0;
        ]
        @test isconst(@__MODULE__, :E)
    end

    @testset "Sadxercism" begin
        @test frown(E) == [
            0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0;
            0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
            0 1 0 0 0 1 0 0 0 0 0 0 1 0 0 0 1 0;
            0 1 0 0 1 0 1 0 0 0 0 1 0 1 0 0 1 0;
            0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
            1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
            0 1 0 0 0 0 0 0 1 1 0 0 0 0 0 0 1 0;
            0 1 0 0 0 0 0 1 0 0 1 0 0 0 0 0 1 0;
            0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0;
            0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
            0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0;
        ]

        Ẽ = copy(E)
        frown!(Ẽ)
        @test Ẽ == [
            0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0;
            0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
            0 1 0 0 0 1 0 0 0 0 0 0 1 0 0 0 1 0;
            0 1 0 0 1 0 1 0 0 0 0 1 0 1 0 0 1 0;
            0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
            1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
            0 1 0 0 0 0 0 0 1 1 0 0 0 0 0 0 1 0;
            0 1 0 0 0 0 0 1 0 0 1 0 0 0 0 0 1 0;
            0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0;
            0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
            0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0;
        ]

        @test Ẽ != E
    end

    @testset "rot -90° / +270°" begin
        @test rot270(E) == [
            0 0 0 0 0 1 0 0 0 0 0;
            0 1 1 1 1 0 1 1 1 1 0;
            1 0 0 0 0 0 0 0 0 0 1;
            1 0 0 0 0 0 0 0 0 0 1;
            0 0 0 1 0 0 0 0 0 0 0;
            0 0 1 0 0 0 0 0 0 0 0;
            0 0 0 1 0 0 1 0 0 0 0;
            0 0 0 0 0 0 0 1 0 0 0;
            0 0 0 0 0 0 0 0 1 0 0;
            0 0 0 0 0 0 0 0 1 0 0;
            0 0 0 0 0 0 0 1 0 0 0;
            0 0 0 1 0 0 1 0 0 0 0;
            0 0 1 0 0 0 0 0 0 0 0;
            0 0 0 1 0 0 0 0 0 0 0;
            1 0 0 0 0 0 0 0 0 0 1;
            1 0 0 0 0 0 0 0 0 0 1;
            0 1 1 1 1 0 1 1 1 1 0;
            0 0 0 0 0 1 0 0 0 0 0;
        ]


        @test rot270(frown(E)) == [
            0 0 0 0 0 1 0 0 0 0 0;
            0 1 1 1 1 0 1 1 1 1 0;
            1 0 0 0 0 0 0 0 0 0 1;
            1 0 0 0 0 0 0 0 0 0 1;
            0 0 0 1 0 0 0 0 0 0 0;
            0 0 1 0 0 0 0 0 0 0 0;
            0 0 0 1 0 0 0 0 1 0 0;
            0 0 0 0 0 0 0 1 0 0 0;
            0 0 0 0 0 0 1 0 0 0 0;
            0 0 0 0 0 0 1 0 0 0 0;
            0 0 0 0 0 0 0 1 0 0 0;
            0 0 0 1 0 0 0 0 1 0 0;
            0 0 1 0 0 0 0 0 0 0 0;
            0 0 0 1 0 0 0 0 0 0 0;
            1 0 0 0 0 0 0 0 0 0 1;
            1 0 0 0 0 0 0 0 0 0 1;
            0 1 1 1 1 0 1 1 1 1 0;
            0 0 0 0 0 1 0 0 0 0 0;
        ]
    end

    @testset "rot +90°" begin
        @test rot90(E) == [
            0 0 0 0 0 1 0 0 0 0 0;
            0 1 1 1 1 0 1 1 1 1 0;
            1 0 0 0 0 0 0 0 0 0 1;
            1 0 0 0 0 0 0 0 0 0 1;
            0 0 0 0 0 0 0 1 0 0 0;
            0 0 0 0 0 0 0 0 1 0 0;
            0 0 0 0 1 0 0 1 0 0 0;
            0 0 0 1 0 0 0 0 0 0 0;
            0 0 1 0 0 0 0 0 0 0 0;
            0 0 1 0 0 0 0 0 0 0 0;
            0 0 0 1 0 0 0 0 0 0 0;
            0 0 0 0 1 0 0 1 0 0 0;
            0 0 0 0 0 0 0 0 1 0 0;
            0 0 0 0 0 0 0 1 0 0 0;
            1 0 0 0 0 0 0 0 0 0 1;
            1 0 0 0 0 0 0 0 0 0 1;
            0 1 1 1 1 0 1 1 1 1 0;
            0 0 0 0 0 1 0 0 0 0 0;
        ]

        @test rot90(frown(E)) == [
            0 0 0 0 0 1 0 0 0 0 0;
            0 1 1 1 1 0 1 1 1 1 0;
            1 0 0 0 0 0 0 0 0 0 1;
            1 0 0 0 0 0 0 0 0 0 1;
            0 0 0 0 0 0 0 1 0 0 0;
            0 0 0 0 0 0 0 0 1 0 0;
            0 0 1 0 0 0 0 1 0 0 0;
            0 0 0 1 0 0 0 0 0 0 0;
            0 0 0 0 1 0 0 0 0 0 0;
            0 0 0 0 1 0 0 0 0 0 0;
            0 0 0 1 0 0 0 0 0 0 0;
            0 0 1 0 0 0 0 1 0 0 0;
            0 0 0 0 0 0 0 0 1 0 0;
            0 0 0 0 0 0 0 1 0 0 0;
            1 0 0 0 0 0 0 0 0 0 1;
            1 0 0 0 0 0 0 0 0 0 1;
            0 1 1 1 1 0 1 1 1 1 0;
            0 0 0 0 0 1 0 0 0 0 0;
        ]
    end

    @testset "stickerwall" begin
        @test stickerwall(E) == [
            0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 1 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0;
            0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
            0 1 0 0 0 1 0 0 0 0 0 0 1 0 0 0 1 0 0 1 0 0 1 0 0 0 1 0 0 0 0 0 0 1 0 0 0 1 0;
            0 1 0 0 1 0 1 0 0 0 0 1 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 1 0 0 0 0 1 0 1 0 0 1 0;
            0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
            1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
            0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 1 0 0 1 0 0 0 0 0 0 1 1 0 0 0 0 0 0 1 0;
            0 1 0 0 0 0 0 1 0 0 1 0 0 0 0 0 1 0 0 1 0 0 1 0 0 0 0 0 1 0 0 1 0 0 0 0 0 1 0;
            0 1 0 0 0 0 0 0 1 1 0 0 0 0 0 0 1 0 0 1 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0;
            0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
            0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 1 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0;
            0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
            1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
            0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
            0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 1 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0;
            0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
            0 1 0 0 0 1 0 0 0 0 0 0 1 0 0 0 1 0 0 1 0 0 1 0 0 0 1 0 0 0 0 0 0 1 0 0 0 1 0;
            0 1 0 0 1 0 1 0 0 0 0 1 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 1 0 0 0 0 1 0 1 0 0 1 0;
            0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
            1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
            0 1 0 0 0 0 0 0 1 1 0 0 0 0 0 0 1 0 0 1 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0;
            0 1 0 0 0 0 0 1 0 0 1 0 0 0 0 0 1 0 0 1 0 0 1 0 0 0 0 0 1 0 0 1 0 0 0 0 0 1 0;
            0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 1 0 0 1 0 0 0 0 0 0 1 1 0 0 0 0 0 0 1 0;
            0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
            0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 1 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0;
        ]
    end
end
