# canonical data version: 1.3.0

using Test

include("acronym.ji")

@testset "makes acronym" begin
      @test acronym("Portable Network Graphics") == "PNG"
end

@testset "fails to make an acronym" begin
      @test acronym("PortableNetworkGraphics") == ""
end
