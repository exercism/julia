using Test

include("wordy.jl")

@testset verbose = true "tests" begin
    @testset "just a number" begin
        @test wordy("What is 5?") == 5
    end
    
    @testset "addition" begin
        @test wordy("What is 1 plus 1?") == 2
    end
    
    @testset "more addition" begin
        @test wordy("What is 53 plus 2?") == 55
    end
    
    @testset "addition with negative numbers" begin
        @test wordy("What is -1 plus -10?") == -11
    end
    
    @testset "large addition" begin
        @test wordy("What is 123 plus 45678?") == 45801
    end
    
    @testset "subtraction" begin
        @test wordy("What is 4 minus -12?") == 16
    end
    
    @testset "multiplication" begin
        @test wordy("What is -3 multiplied by 25?") == -75
    end
    
    @testset "division" begin
        @test wordy("What is 33 divided by -3?") == -11
    end
    
    @testset "multiple additions" begin
        @test wordy("What is 1 plus 1 plus 1?") == 3
    end
    
    @testset "addition and subtraction" begin
        @test wordy("What is 1 plus 5 minus -2?") == 8
    end
    
    @testset "multiple subtraction" begin
        @test wordy("What is 20 minus 4 minus 13?") == 3
    end
    
    @testset "subtraction then addition" begin
        @test wordy("What is 17 minus 6 plus 3?") == 14
    end
    
    @testset "multiple multiplication" begin
        @test wordy("What is 2 multiplied by -2 multiplied by 3?") == -12
    end
    
    @testset "addition and multiplication" begin
        @test wordy("What is -3 plus 7 multiplied by -2?") == -8
    end
    
    @testset "multiple division" begin
        @test wordy("What is -12 divided by 2 divided by -3?") == 2
    end
    
    @testset "unknown operation" begin
        @test_throws ArgumentError wordy("What is 52 cubed?")
    end
    
    @testset "Non math question" begin
        @test_throws ArgumentError wordy("Who is the President of the United States?")
    end
    
    @testset "reject problem missing an operand" begin
        @test_throws ArgumentError wordy("What is 1 plus?")
    end
    
    @testset "reject problem with no operands or operators" begin
        @test_throws ArgumentError wordy("What is?")
    end
    
    @testset "reject two operations in a row" begin
        @test_throws ArgumentError wordy("What is 1 plus plus 2?")
    end
    
    @testset "reject two numbers in a row" begin
        @test_throws ArgumentError wordy("What is 1 plus 2 1?")
    end
    
    @testset "reject postfix notation" begin
        @test_throws ArgumentError wordy("What is 1 2 plus?")
    end
    
    @testset "reject prefix notation" begin
        @test_throws ArgumentError wordy("What is plus 1 2?")
    end
end
