using Test

include("phone-number.jl")

# Tests adapted from `problem-specifications//canonical-data.json` @ v1.2.0
# Returns the cleaned phone number as a digit string if given number is valid,
# else returns `nothing`.

const expected_number = "2234567890"
const valid_10digit_num = (
        "(223) 456-7890",
        "223.456.7890",
        "223 456   7890   ",
)
const valid_11digit_num = (
        "12234567890",
        "  1 223 456 7890 ",
        "+1 (223) 456-7890",
)
const invalid_num = (
        "123456789",
        "1223456789",
        "22234567890",
        "321234567890",
        "223-abc-7890",
        "223-@:!-7890",
        "(023) 456-7890",
        "(123) 456-7890",
        "(223) 056-7890",
        "(223) 156-7890",
        "1 (023) 456-7890",
        "1 (123) 456-7890",
        "1 (223) 056-7890",
        "1 (223) 156-7890",
)

@testset "clean 10-digit number" begin
    @testset "$number" for number in valid_10digit_num
        @test clean(number) == expected_number
    end
end

@testset "clean 11-digit number starting with 1" begin
    @testset "$number" for number in valid_11digit_num
        @test clean(number) == expected_number
    end
end

@testset "detect invalid number" begin
    @testset "$number" for number in invalid_num
        @test_throws ArgumentError clean(number)
    end
end
