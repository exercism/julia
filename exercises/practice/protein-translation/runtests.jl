using Test

include("protein-translation.jl")

@testset verbose = true "tests" begin
    @testset "Empty RNA sequence results in no proteins" begin
        @test proteins("") == []
    end

    @testset "Methionine RNA sequence" begin
        @test proteins("AUG") == ["Methionine"]
    end

    @testset "Phenylalanine RNA sequence 1" begin
        @test proteins("UUU") == ["Phenylalanine"]
    end

    @testset "Phenylalanine RNA sequence 2" begin
        @test proteins("UUC") == ["Phenylalanine"]
    end

    @testset "Leucine RNA sequence 1" begin
        @test proteins("UUA") == ["Leucine"]
    end

    @testset "Leucine RNA sequence 2" begin
        @test proteins("UUG") == ["Leucine"]
    end

    @testset "Serine RNA sequence 1" begin
        @test proteins("UCU") == ["Serine"]
    end

    @testset "Serine RNA sequence 2" begin
        @test proteins("UCC") == ["Serine"]
    end

    @testset "Serine RNA sequence 3" begin
        @test proteins("UCA") == ["Serine"]
    end

    @testset "Serine RNA sequence 4" begin
        @test proteins("UCG") == ["Serine"]
    end

    @testset "Tyrosine RNA sequence 1" begin
        @test proteins("UAU") == ["Tyrosine"]
    end

    @testset "Tyrosine RNA sequence 2" begin
        @test proteins("UAC") == ["Tyrosine"]
    end

    @testset "Cysteine RNA sequence 1" begin
        @test proteins("UGU") == ["Cysteine"]
    end

    @testset "Cysteine RNA sequence 2" begin
        @test proteins("UGC") == ["Cysteine"]
    end

    @testset "Tryptophan RNA sequence" begin
        @test proteins("UGG") == ["Tryptophan"]
    end

    @testset "STOP codon RNA sequence 1" begin
        @test proteins("UAA") == []
    end

    @testset "STOP codon RNA sequence 2" begin
        @test proteins("UAG") == []
    end

    @testset "STOP codon RNA sequence 3" begin
        @test proteins("UGA") == []
    end

    @testset "Sequence of two protein codons translates into proteins" begin
        @test proteins("UUUUUU") == ["Phenylalanine", "Phenylalanine"]
    end

    @testset "Sequence of two different protein codons translates into proteins" begin
        @test proteins("UUAUUG") == ["Leucine", "Leucine"]
    end

    @testset "Translate RNA strand into correct protein list" begin
        @test proteins("AUGUUUUGG") == ["Methionine", "Phenylalanine", "Tryptophan"]
    end

    @testset "Translation stops if STOP codon at beginning of sequence" begin
        @test proteins("UAGUGG") == []
    end

    @testset "Translation stops if STOP codon at end of two-codon sequence" begin
        @test proteins("UGGUAG") == ["Tryptophan"]
    end

    @testset "Translation stops if STOP codon at end of three-codon sequence" begin
        @test proteins("AUGUUUUAA") == ["Methionine", "Phenylalanine"]
    end

    @testset "Translation stops if STOP codon in middle of three-codon sequence" begin
        @test proteins("UGGUAGUGG") == ["Tryptophan"]
    end

    @testset "Translation stops if STOP codon in middle of six-codon sequence" begin
        @test proteins("UGGUGUUAUUAAUGGUUU") == ["Tryptophan", "Cysteine", "Tyrosine"]
    end

    @testset "Sequence of two non-STOP codons does not translate to a STOP codon" begin
        @test proteins("AUGAUG") == ["Methionine", "Methionine"]
    end

    @testset "Non-existing codon can't translate" begin
        @test_throws DomainError proteins("AAA")
    end

    @testset "Unknown amino acids, not part of a codon, can't translate" begin
        @test_throws DomainError proteins("XYZ")
    end

    @testset "Incomplete RNA sequence can't translate" begin
        @test_throws DomainError proteins("AUGU")
    end

    @testset "Incomplete RNA sequence can translate if valid until a STOP codon" begin
        @test proteins("UUCUUCUAAUGGU") == ["Phenylalanine", "Phenylalanine"]
    end
end
