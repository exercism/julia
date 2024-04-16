using Test

include("raindrops.jl")

@testset verbose = true "tests" begin
    @testset "detect numbers" begin
        @testset "the sound for 1 is 1" begin
          @test raindrops(1) == "1"
        end
        @testset "2 to the power 3 does not make a raindrop sound as 3 is the exponent not the base" begin
          @test raindrops(8) == "8"
        end
        @testset "the sound for 52 is 52" begin
          @test raindrops(52) == "52"
        end
    end

    @testset "detect pling" begin
        @testset "the sound for 3 is Pling" begin
          @test raindrops(3) == "Pling"
        end
        @testset "the sound for 6 is Pling as it has a factor 3" begin
          @test raindrops(6) == "Pling"
        end
        @testset "the sound for 9 is Pling as it has a factor 3" begin
          @test raindrops(9) == "Pling"
        end
        @testset "the sound for 27 is Pling as it has a factor 3" begin
          @test raindrops(27) == "Pling"
        end
    end

    @testset "detect plang" begin
        @testset "the sound for 5 is Plang" begin
          @test raindrops(5) == "Plang"
        end
        @testset "the sound for 10 is Plang as it has a factor 5" begin
          @test raindrops(10) == "Plang"
        end
        @testset "the sound for 25 is Plang as it has a factor 5" begin
          @test raindrops(25) == "Plang"
        end
        @testset "the sound for 3125 is Plang as it has a factor 5" begin
          @test raindrops(3125) == "Plang"
        end
    end

    @testset "detect plong" begin
        @testset "the sound for 7 is Plong" begin
          @test raindrops(7) == "Plong"
        end
        @testset "the sound for 14 is Plong as it has a factor of 7" begin
          @test raindrops(14) == "Plong"
        end
        @testset "the sound for 49 is Plong as it has a factor 7" begin
          @test raindrops(49) == "Plong"
        end
    end

    @testset "detect multiple sounds" begin
        @testset "the sound for 15 is PlingPlang as it has factors 3 and 5" begin
          @test raindrops(15) == "PlingPlang"
        end
        @testset "the sound for 21 is PlingPlong as it has factors 3 and 7" begin
          @test raindrops(21) == "PlingPlong"
        end
        @testset "the sound for 35 is PlangPlong as it has factors 5 and 7" begin
          @test raindrops(35) == "PlangPlong"
        end
        @testset "the sound for 105 is PlingPlangPlong as it has factors 3, 5 and 7" begin
          @test raindrops(105) == "PlingPlangPlong"
        end
    end
end
