using Test

include("pig-latin.jl")

@testset verbose = true "tests" begin
    @testset "ay is added to words that begin with vowels" begin
        @testset "word beginning with a" begin
            @test translate("apple") == "appleay"
        end

        @testset "word beginning with e" begin
            @test translate("ear") == "earay"
        end

        @testset "word beginning with i" begin
            @test translate("igloo") == "iglooay"
        end

        @testset "word beginning with o" begin
            @test translate("object") == "objectay"
        end

        @testset "word beginning with u" begin
            @test translate("under") == "underay"
        end

        @testset "word beginning with a vowel and followed by a qu" begin
            @test translate("equal") == "equalay"
        end
    end

    @testset "first letter and ay are moved to the end of words that start with consonants" begin
        @testset "word beginning with p" begin
            @test translate("pig") == "igpay"
        end
    
        @testset "word beginning with k" begin
            @test translate("koala") == "oalakay"
        end
    
        @testset "word beginning with x" begin
            @test translate("xenon") == "enonxay"
        end
    
        @testset "word beginning with q without a following u" begin
            @test translate("qat") == "atqay"
        end
    end

    @testset "some letter clusters are treated like a single consonant" begin
        @testset "word beginning with ch" begin
            @test translate("chair") == "airchay"
        end
    
        @testset "word beginning with qu" begin
            @test translate("queen") == "eenquay"
        end
    
        @testset "word beginning with qu and a preceding consonant" begin
            @test translate("square") == "aresquay"
        end
    
        @testset "word beginning with th" begin
            @test translate("therapy") == "erapythay"
        end
    
        @testset "word beginning with thr" begin
            @test translate("thrush") == "ushthray"
        end
    
        @testset "word beginning with sch" begin
            @test translate("school") == "oolschay"
        end
    end

    @testset "some letter clusters are treated like a single vowel" begin
        @testset "word beginning with yt" begin
            @test translate("yttria") == "yttriaay"
        end
    
        @testset "word beginning with xr" begin
            @test translate("xray") == "xrayay"
        end
    end

    @testset "position of y in a word determines if it is a consonant or a vowel" begin
        @testset "y is treated like a consonant at the beginning of a word" begin
            @test translate("yellow") == "ellowyay"
        end
    
        @testset "y is treated like a vowel at the end of a consonant cluster" begin
            @test translate("rhythm") == "ythmrhay"
        end
    
        @testset "y as second letter in two letter word" begin
            @test translate("my") == "ymay"
        end
    end
    
    @testset "phrases are translated" begin
        @testset "a whole phrase" begin
            @test translate("quick fast run") == "ickquay astfay unray"
        end
    end
end
