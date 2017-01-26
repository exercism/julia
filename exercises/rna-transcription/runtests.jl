using Base.Test

include("rna-transcription.jl")

@testset "" begin
  @test to_rna("") == ""
  @test_throws ArgumentError to_rna("")
end

