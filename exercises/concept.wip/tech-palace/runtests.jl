using Test

include("welcome.jl")

@testset "1. Create the welcome message" begin
    @testset "Welcome message for customer with first letter capitalized" begin
        @test welcome("Formora") == "Welcome to the Tech Palace, FORMORA"
    end

    @testset "Welcome message for customer with only lowercase letters" begin
        @test welcome("oromis") == "Welcome to the Tech Palace, OROMIS"
    end

    @testset "Welcome message for customer with dash in name" begin
        @test welcome("Svit-kona") == "Welcome to the Tech Palace, SVIT-KONA"
    end

    @testset "Welcome message for customer with only uppercase letters" begin
        @test welcome("ARVA") == "Welcome to the Tech Palace, ARVA"
    end

    @testset "Welcome message for customer with non-latin letters" begin
        @test welcome("Andumë") == "Welcome to the Tech Palace, ANDUMË"
    end
end

@testset "2. Add a fancy border" begin
    @testset "Add border with 10 stars per line" begin
        @test add_border("Welcome!", 10) == "**********\nWelcome!\n**********"
    end

    @testset "Add border with 2 stars per line" begin
        @test add_border("Hi", 2) == "**\nHi\n**"
    end
end

@testset "3. Clean up old marketing messages" begin
    @testset "Cleanup message with leading whitespace" begin
        @test clean("                DISCOUNT") == "DISCOUNT"
    end

    @testset "Cleanup message with trailing whitespace" begin
        @test clean("SALE      ") == "SALE"
    end

    @testset "Cleanup message with leading and trailing whitespace" begin
        @test clean("    BUY NOW, SAVE 10%   ") == "BUY NOW, SAVE 10%"
    end
end
