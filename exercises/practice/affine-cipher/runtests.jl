# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/affine-cipher/canonical-data.json
# File last updated on 2026-08-29

using Test

include("affine-cipher.jl")

@testset verbose = true "tests" begin
    @testset "encode" begin
        @testset "encode yes" begin
            @test encode("yes", 5, 7) == "xbt"
        end

        @testset "encode no" begin
            @test encode("no", 15, 18) == "fu"
        end

        @testset "encode OMG" begin
            @test encode("OMG", 21, 3) == "lvz"
        end

        @testset "encode O M G" begin
            @test encode("O M G", 25, 47) == "hjp"
        end

        @testset "encode mindblowingly" begin
            @test encode("mindblowingly", 11, 15) == "rzcwa gnxzc dgt"
        end

        @testset "encode numbers" begin
            @test encode("Testing,1 2 3, testing.", 3, 4) == "jqgjc rw123 jqgjc rw"
        end

        @testset "encode deep thought" begin
            @test encode("Truth is fiction.", 5, 17) == "iynia fdqfb ifje"
        end

        @testset "encode all the letters" begin
            @test encode("The quick brown fox jumps over the lazy dog.", 17, 33) ==
                  "swxtj npvyk lruol iejdc blaxk swxmh qzglf"
        end

        @testset "encode with a not coprime to m" begin
            @test_throws ArgumentError encode("This is a test.", 6, 17)
        end
    end

    @testset "decode" begin
        @testset "decode exercism" begin
            @test decode("tytgn fjr", 3, 7) == "exercism"
        end

        @testset "decode a sentence" begin
            @test decode("qdwju nqcro muwhn odqun oppmd aunwd o", 19, 16) ==
                  "anobstacleisoftenasteppingstone"
        end

        @testset "decode numbers" begin
            @test decode("odpoz ub123 odpoz ub", 25, 7) == "testing123testing"
        end

        @testset "decode all the letters" begin
            @test decode("swxtj npvyk lruol iejdc blaxk swxmh qzglf", 17, 33) ==
                  "thequickbrownfoxjumpsoverthelazydog"
        end

        @testset "decode with no spaces in input" begin
            @test decode("swxtjnpvyklruoliejdcblaxkswxmhqzglf", 17, 33) ==
                  "thequickbrownfoxjumpsoverthelazydog"
        end

        @testset "decode with too many spaces" begin
            @test decode("vszzm    cly   yd cg    qdp", 15, 16) == "jollygreengiant"
        end

        @testset "decode with a not coprime to m" begin
            @test_throws ArgumentError decode("Test", 13, 5)
        end
    end
end
