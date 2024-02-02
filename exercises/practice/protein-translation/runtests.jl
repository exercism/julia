using Test

include("protein-translation.jl")

@testset "Protein Translation" begin

    @testset "Empty RNA sequence returns an empty list" begin
        @test rna"" == []
    end

    @testset "Methionine RNA sequence is decoded as Methionine" begin
        @test rna_translator("AUG") == ["Methionine"]
    end

    @testset "Phenylalanine RNA sequence is decoded as Phenylalanine" begin
        @test rna_translator("UUUUUC") == ["Phenylalanine", "Phenylalanine"]
    end

    @testset "Leucine RNA sequence is decoded as Leucine" begin
        @test rna_translator("UUA") == ["Leucine"]
    end

    @testset "Leucine RNA sequence is decoded as Leucine" begin
        @test rna_translator("UUG") == ["Leucine"]
    end

    @testset "Serine RNA sequence is decoded as Serine" begin
        @test rna_translator("UCUUCCUCAUCG") == ["Serine", "Serine", "Serine", "Serine"]
    end

    @testset "Tyrosine RNA sequence is decoded as Tyrosine" begin
        @test rna_translator("UAUUAC") == ["Tyrosine", "Tyrosine"]
    end

    @testset "Cysteine RNA sequence is decoded as Cysteine" begin
        @test rna_translator("UGUUGC") == ["Cysteine", "Cysteine"]
    end

    @testset "Tryptophan RNA sequence is decoded as Tryptophan" begin
        @test rna_translator("UGG") == ["Tryptophan"]
    end

    @testset "STOP codon terminates translation" begin
        @test rna_translator("UAA") == []
        @test rna_translator("UAG") == []
        @test rna_translator("UGA") == []
    end

    @testset "Sequence of two codons translates into proteins" begin
        @test rna_translator("UUUUUUUGA") == ["Phenylalanine", "Phenylalanine"]
    end

    @testset "Sequence of two different codons translates into proteins" begin
        @test rna_translator("UUAUUUUAG") == ["Leucine", "Phenylalanine"]
    end

    @testset "Translation stops if STOP codon appears in middle of sequence" begin
        @test rna_translator("UGGUAAUGCAUG") == ["Tryptophan"]
    end

    @testset "Translation stops if STOP codon appears at beginning of sequence" begin
        @test rna_translator("UAGUAUUCGUCAUCU") == []
    end

    @testset "Translation stops if STOP codon appears at end of two-codon sequence" begin
        @test rna_translator("UGGUGUUGA") == ["Tryptophan", "Cysteine", "Tyrosine"]
    end

    @testset "Non existent codon causes translation exception" begin
        @test_throws TranslationError rna_translator("AAA")
    end

    @testset "Incomplete codon causes translation exception" begin
        @test_throws TranslationError rna_translator("UGUU")
    end

    @testset "Incomplete RNA sequence can translate if given a stop codon" begin
        @test rna_translator("UGGUGAUG") == ["Tryptophan"]
    end
end