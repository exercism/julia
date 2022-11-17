using Test

include("lasagna.jl")

# Dear Julia learner,
# If you're reading this test suite to gain some insights, please be advised that it is somewhat unusual.
#
# Don't worry if you don't understand this test suite at this stage of your learning journey.
# We had to use some advanced features to be able to write assertions about docstrings.
# You wouldn't normally write assertions for that in a typical codebase.
# We're doing it here strictly for educational purposes.

"""
    hasdocstring(s::Symbol)

Return true if the binding `s` in `@__MODULE__` has a docstring

**Credit:** https://julialang.zulipchat.com/#narrow/stream/225542-helpdesk/topic/finding.20out.20if.20a.20function.20has.20a.20docstring
"""
function hasdocstring(s::Symbol)
    meta = Docs.meta(@__MODULE__)
    haskey(meta, Docs.Binding(@__MODULE__, s))
end

@testset "solution still works" begin
    @test preptime(2) == 4
    @test preptime(3) == 6
    @test preptime(8) == 16
    @test remaining_time(30) == 30
    @test remaining_time(50) == 10
    @test remaining_time(60) == 0
    @test total_working_time(3, 20) == 26
end

@testset "preptime has a docstring" begin
    @test hasdocstring(:preptime)
end

@testset "remaining_time has a docstring" begin
    @test hasdocstring(:remaining_time)
end

@testset "total_working_time has a docstring" begin
    @test hasdocstring(:total_working_time)
end
