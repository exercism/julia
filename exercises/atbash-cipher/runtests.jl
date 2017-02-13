using Base.Test

include("atbash-cipher.jl")

@testset "encoding from English to atbash" begin
    @testset "encode yes" begin
        @test encode("yes") == "bvh"
    end

    @testset "encode no" begin
        @test encode("no") == "ml"
    end

    @testset "encode OMG" begin
        @test encode("OMG") == "lnt"
    end

    @testset "encode spaces" begin
        @test encode("O M G") == "lnt"
    end

    @testset "encode mindblowingly" begin
        @test encode("mindblowingly") == "nrmwy oldrm tob"
    end

    @testset "encode numbers" begin
        @test encode("Testing,1 2 3, testing.") == "gvhgr mt123 gvhgr mt"
    end

    @testset "encode deep thought" begin
        @test encode("Truth is fiction.") == "gifgs rhurx grlm"
    end

    @testset "encode all the letters" begin
        @test encode("The quick brown fox jumps over the lazy dog.") == "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"
    end
end

@testset "decoding from atbash to English" begin
    @testset "decode exercism" begin
        @test decode("vcvix rhn") == "exercism"
    end

    @testset "decode a sentence" begin
        @test decode("zmlyh gzxov rhlug vmzhg vkkrm thglm v") == "anobstacleisoftenasteppingstone"
    end

    @testset "decode numbers" begin
        @test decode("gvhgr mt123 gvhgr mt") == "testing123testing"
    end

    @testset "decode all the letters" begin
        @test decode("gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt") == "thequickbrownfoxjumpsoverthelazydog"
    end
end

