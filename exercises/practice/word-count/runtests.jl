using Test

include("word-count.jl")

@testset "no words" begin
    @test wordcount(" .\n,\t!^&*()~@#\$%{}[]:;'/<>") == Dict()
end

@testset "count one word" begin
    @test wordcount("word") == Dict("word" => 1)
end

@testset "count one of each word" begin
    @test wordcount("one of each") == Dict("one" => 1, "of" => 1, "each" => 1)
end

@testset "multiple occurrences of a word" begin
    @test wordcount("one fish two fish red fish blue fish") == Dict("one" => 1, "fish" => 4, "two" => 1, "red" => 1, "blue" => 1)
end

@testset "handles cramped lists" begin
    @test wordcount("one,two,three") == Dict("one" => 1, "two" => 1, "three" => 1)
end

@testset "handles expanded lists" begin
    @test wordcount("one,\ntwo,\nthree") == Dict("one" => 1, "two" => 1, "three" => 1)
end

@testset "ignore punctuation" begin
    @test wordcount("car: carpet as java: javascript!!&@\$%^&") == Dict("car" => 1, "carpet" => 1, "as" => 1, "java" => 1, "javascript" => 1)
end

@testset "include numbers" begin
    @test wordcount("testing, 1, 2 testing") == Dict("testing" => 2, "1" => 1, "2" => 1)
end

@testset "normalize case" begin
    @test wordcount("go Go GO Stop stop") == Dict("go" => 3, "stop" => 2)
end

@testset "with apostrophes" begin
    @test wordcount("First: don't laugh. Then: don't cry.") == Dict("first" => 1, "don't" => 2, "laugh" => 1, "then" => 1, "cry" => 1)
    @test wordcount("Should've could've would've") == Dict("should've" => 1, "could've" => 1, "would've" => 1)
end

@testset "with quotations" begin
    @test wordcount("Joe can't tell between 'large' and large.") == Dict("joe" => 1, "can't" => 1, "tell" => 1, "between" => 1, "large" => 2, "and" => 1)
end

@testset "substrings from the beginning" begin
    @test wordcount("Joe can't tell between app, apple and a.") == Dict("joe" => 1, "can't" => 1, "tell" => 1, "between" => 1, "app" => 1, "apple" => 1, "and" => 1, "a" => 1)
end

@testset "multiple spaces not detected as a word" begin
    @test wordcount(" multiple   whitespaces") == Dict("multiple" => 1, "whitespaces" => 1)
end

@testset "alternating word separators not detected as a word" begin
    @test wordcount(",\n,one,\n ,two \n 'three'") == Dict("one" => 1, "two" => 1, "three" => 1)
end
