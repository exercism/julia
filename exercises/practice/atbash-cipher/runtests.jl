using Test

include("atbash-cipher.jl")

@testset "encoding from English to atbash" begin
    @test encode("yes") == "bvh"
    @test encode("no") == "ml"
    @test encode("OMG") == "lnt"
    @test encode("O M G") == "lnt"
    @test encode("mindblowingly") == "nrmwy oldrm tob"
    @test encode("Testing,1 2 3, testing.") == "gvhgr mt123 gvhgr mt"
    @test encode("Truth is fiction.") == "gifgs rhurx grlm"
    @test encode("The quick brown fox jumps over the lazy dog.") == "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"
end

@testset "decoding from atbash to English" begin
    @test decode("vcvix rhn") == "exercism"
    @test decode("zmlyh gzxov rhlug vmzhg vkkrm thglm v") == "anobstacleisoftenasteppingstone"
    @test decode("gvhgr mt123 gvhgr mt") == "testing123testing"
    @test decode("gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt") == "thequickbrownfoxjumpsoverthelazydog"
    @test decode("vc vix    r hn") == "exercism"
    @test decode("zmlyhgzxovrhlugvmzhgvkkrmthglmv") == "anobstacleisoftenasteppingstone"
end

