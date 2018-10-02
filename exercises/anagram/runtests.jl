# canonical data version: 1.3.0

using Test

include("anagram.jl")

@testset "no matches" begin
    @test detect_anagrams("diaper", ["hello", "world", "zombies", "pants"]) == []
end

@testset "detects simple anagram" begin
    @test detect_anagrams("ant", ["tan", "stand", "at"]) == ["tan"]
end

@testset "does not detect false positives" begin
    @test detect_anagrams("galea", ["eagle"]) == []
end

@testset "detects two anagrams" begin
    @test detect_anagrams("master", ["stream", "pigeon", "maters"]) == ["stream", "maters"]
end

@testset "does not detect anagram subsets" begin
    @test detect_anagrams("good", ["dog", "goody"]) == []
end

@testset "detects anagram" begin
    @test detect_anagrams("listen", ["enlists", "google", "inlets", "banana"]) == ["inlets"]
end

@testset "detects three anagrams" begin
    @test detect_anagrams("allergy", ["gallery", "ballerina", "regally", "clergy", "largely", "leading"]) == ["gallery", "regally", "largely"]
end

@testset "does not detect identical words" begin
    @test detect_anagrams("corn", ["corn", "dark", "Corn", "rank", "CORN", "cron", "park"]) == ["cron"]
end

@testset "does not detect non-anagrams with identical checksum" begin
    @test detect_anagrams("mass", ["last"]) == []
end

@testset "detects anagrams case-insensitively" begin
    @test detect_anagrams("Orchestra", ["cashregister", "Carthorse", "radishes"]) == ["Carthorse"]
end

@testset "detects anagrams using case-insensitive subject" begin
    @test detect_anagrams("Orchestra", ["cashregister", "carthorse", "radishes"]) == ["carthorse"]
end

@testset "detects anagrams using case-insensitive possible matches" begin
    @test detect_anagrams("orchestra", ["cashregister", "Carthorse", "radishes"]) == ["Carthorse"]
end

@testset "does not detect a word as its own anagram" begin
    @test detect_anagrams("banana", ["Banana"]) == []
end

@testset "does not detect a anagram if the original word is repeated" begin
    @test detect_anagrams("go", ["go Go GO"]) == []
end

@testset "anagrams must use all letters exactly once" begin
    @test detect_anagrams("tapper", ["patter"]) == []
end

@testset "capital word is not own anagram" begin
    @test detect_anagrams("BANANA", ["Banana"]) == []
end
