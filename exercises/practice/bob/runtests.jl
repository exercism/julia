using Test

include("bob.jl")

questions = (
        "Does this cryogenic chamber make me look fat?",
        "Hä?",
        "You are, what, like 15?",
        "fffbbcbeab?",
        "4?", ":) ?",
        "Wait! Hang on. Are you going to be OK?",
        "Okay if like my  spacebar  quite a bit?   ",
        "Oida?",
)

yells = (
        "WATCH OUT!",
        "FCECDFCAAB",
        "FCÄEÜCÖDFCẞAB",
        "1, 2, 3 GO!",
        "ZOMG THE %^*@#\$(*^ ZOMBIES ARE COMING!!11!!1!",
        "I HATE YOU",
        "I HATE THE DENTIST",
        "OIDA!",
)

silences = (
        "",
        "          ",
        "\t\t\t\t\t\t\t\t\t\t",
        "\n\r \t",
)

miscs = (
        "Tom-ay-to, tom-aaaah-to.",
        "Let's go make out behind the gym!",
        "It's OK if you don't want to work for the NSA.",
        "Es ist okay, wenn du nicht für den BND arbeiten möchtest.",
        "1, 2, 3",
        "Ending with ? means a question.",
        "\nDoes this cryogenic chamber make me look fat?\nno",
        "         hmmmmmmm...",
        "This is a statement ending with whitespace      ",
        "Oida.",
)

forceful_questions = (
        "WHAT THE HELL WERE YOU THINKING?",
        "WAS ZUR HÖLLE GEHT HIER VOR?",
        "OIDA?",
)

response = Dict(
        :question => "Sure.",
        :yelling => "Whoa, chill out!",
        :silence => "Fine. Be that way!",
        :misc => "Whatever.",
        :forceful_question => "Calm down, I know what I'm doing!",
)

@testset "questions" begin
    @testset "$question" for question in questions
        @test bob(question) == response[:question]
    end
end

@testset "yelling" begin
    @testset "$yell" for yell in yells
        @test bob(yell) == response[:yelling]
    end
end

@testset "silence" begin
    @testset "$silence" for silence in silences
        @test bob(silence) == response[:silence]
    end
end

@testset "misc" begin
    @testset "$misc" for misc in miscs
        @test bob(misc) == response[:misc]
    end
end

@testset "forceful questions" begin
    @testset "$question" for question in forceful_questions
        @test bob(question) == response[:forceful_question]
    end 
end
