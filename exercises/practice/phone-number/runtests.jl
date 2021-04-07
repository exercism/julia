using Test

include("phone-number.jl")

# Julia 1.0 compat
if VERSION < v"1.1"
    @eval isnothing(::Any) = false
    @eval isnothing(::Nothing) = true
end

# I think this part is redundant since it's not longer a problem (inwalid number test was removerd to match project instructions)

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

