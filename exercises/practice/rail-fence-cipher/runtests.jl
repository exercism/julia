# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/rail-fence-cipher/canonical-data.json
# File last updated on 2026-11-21

using Test

include("rail-fence-cipher.jl")

@testset verbose = true "tests" begin
    @testset "encode" begin
        @testset "encode with two rails" begin
            @test encode("XOXOXOXOXOXOXOXOXO", 2) == "XXXXXXXXXOOOOOOOOO"
        end

        @testset "encode with three rails" begin
            @test encode("WEAREDISCOVEREDFLEEATONCE", 3) == "WECRLTEERDSOEEFEAOCAIVDEN"
        end

        @testset "encode with ending in the middle" begin
            @test encode("EXERCISES", 4) == "ESXIEECSR"
        end
    end

    @testset "decode" begin
        @testset "decode with three rails" begin
            @test decode("TEITELHDVLSNHDTISEIIEA", 3) == "THEDEVILISINTHEDETAILS"
        end

        @testset "decode with five rails" begin
            @test decode("EIEXMSMESAORIWSCE", 5) == "EXERCISMISAWESOME"
        end

        @testset "decode with six rails" begin
            @test decode("133714114238148966225439541018335470986172518171757571896261",
                6) ==
                "112358132134558914423337761098715972584418167651094617711286"
        end
    end
end
