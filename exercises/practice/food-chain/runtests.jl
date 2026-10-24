# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/food-chain/canonical-data.json
# File last updated on 2026-10-24

using Test

include("food-chain.jl")

@testset verbose = true "tests" begin
    @testset "fly" begin
        @test recite(1, 1) == ["I know an old lady who swallowed a fly.",
                               "I don't know why she swallowed the fly. Perhaps she'll die."]
    end

    @testset "spider" begin
        @test recite(2, 2) == ["I know an old lady who swallowed a spider.",
                               "It wriggled and jiggled and tickled inside her.",
                               "She swallowed the spider to catch the fly.",
                               "I don't know why she swallowed the fly. Perhaps she'll die."]
    end

    @testset "bird" begin
        @test recite(3, 3) ==
              ["I know an old lady who swallowed a bird.", "How absurd to swallow a bird!",
               "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
               "She swallowed the spider to catch the fly.",
               "I don't know why she swallowed the fly. Perhaps she'll die."]
    end

    @testset "cat" begin
        @test recite(4, 4) ==
              ["I know an old lady who swallowed a cat.", "Imagine that, to swallow a cat!",
               "She swallowed the cat to catch the bird.",
               "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
               "She swallowed the spider to catch the fly.",
               "I don't know why she swallowed the fly. Perhaps she'll die."]
    end

    @testset "dog" begin
        @test recite(5, 5) ==
              ["I know an old lady who swallowed a dog.", "What a hog, to swallow a dog!",
               "She swallowed the dog to catch the cat.",
               "She swallowed the cat to catch the bird.",
               "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
               "She swallowed the spider to catch the fly.",
               "I don't know why she swallowed the fly. Perhaps she'll die."]
    end

    @testset "goat" begin
        @test recite(6, 6) == ["I know an old lady who swallowed a goat.",
                               "Just opened her throat and swallowed a goat!",
                               "She swallowed the goat to catch the dog.",
                               "She swallowed the dog to catch the cat.",
                               "She swallowed the cat to catch the bird.",
                               "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
                               "She swallowed the spider to catch the fly.",
                               "I don't know why she swallowed the fly. Perhaps she'll die."]
    end

    @testset "cow" begin
        @test recite(7, 7) == ["I know an old lady who swallowed a cow.",
                               "I don't know how she swallowed a cow!",
                               "She swallowed the cow to catch the goat.",
                               "She swallowed the goat to catch the dog.",
                               "She swallowed the dog to catch the cat.",
                               "She swallowed the cat to catch the bird.",
                               "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
                               "She swallowed the spider to catch the fly.",
                               "I don't know why she swallowed the fly. Perhaps she'll die."]
    end

    @testset "horse" begin
        @test recite(8, 8) ==
              ["I know an old lady who swallowed a horse.", "She's dead, of course!"]
    end

    @testset "multiple verses" begin
        @test recite(1, 3) == ["I know an old lady who swallowed a fly.",
                               "I don't know why she swallowed the fly. Perhaps she'll die.", "",
                               "I know an old lady who swallowed a spider.",
                               "It wriggled and jiggled and tickled inside her.",
                               "She swallowed the spider to catch the fly.",
                               "I don't know why she swallowed the fly. Perhaps she'll die.", "",
                               "I know an old lady who swallowed a bird.", "How absurd to swallow a bird!",
                               "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
                               "She swallowed the spider to catch the fly.",
                               "I don't know why she swallowed the fly. Perhaps she'll die."]
    end

    @testset "full song" begin
        @test recite(1, 8) == ["I know an old lady who swallowed a fly.",
                               "I don't know why she swallowed the fly. Perhaps she'll die.", "",
                               "I know an old lady who swallowed a spider.",
                               "It wriggled and jiggled and tickled inside her.",
                               "She swallowed the spider to catch the fly.",
                               "I don't know why she swallowed the fly. Perhaps she'll die.", "",
                               "I know an old lady who swallowed a bird.", "How absurd to swallow a bird!",
                               "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
                               "She swallowed the spider to catch the fly.",
                               "I don't know why she swallowed the fly. Perhaps she'll die.", "",
                               "I know an old lady who swallowed a cat.", "Imagine that, to swallow a cat!",
                               "She swallowed the cat to catch the bird.",
                               "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
                               "She swallowed the spider to catch the fly.",
                               "I don't know why she swallowed the fly. Perhaps she'll die.", "",
                               "I know an old lady who swallowed a dog.", "What a hog, to swallow a dog!",
                               "She swallowed the dog to catch the cat.",
                               "She swallowed the cat to catch the bird.",
                               "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
                               "She swallowed the spider to catch the fly.",
                               "I don't know why she swallowed the fly. Perhaps she'll die.", "",
                               "I know an old lady who swallowed a goat.",
                               "Just opened her throat and swallowed a goat!",
                               "She swallowed the goat to catch the dog.",
                               "She swallowed the dog to catch the cat.",
                               "She swallowed the cat to catch the bird.",
                               "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
                               "She swallowed the spider to catch the fly.",
                               "I don't know why she swallowed the fly. Perhaps she'll die.", "",
                               "I know an old lady who swallowed a cow.",
                               "I don't know how she swallowed a cow!",
                               "She swallowed the cow to catch the goat.",
                               "She swallowed the goat to catch the dog.",
                               "She swallowed the dog to catch the cat.",
                               "She swallowed the cat to catch the bird.",
                               "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
                               "She swallowed the spider to catch the fly.",
                               "I don't know why she swallowed the fly. Perhaps she'll die.", "",
                               "I know an old lady who swallowed a horse.", "She's dead, of course!"]
    end
end
