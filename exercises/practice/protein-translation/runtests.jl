using Test

include("protein-translation.jl")

@testset "Protein Translation" begin

    @testset "Empty RNA sequence returns an empty list" begin
        @test rna"" == []
    end

    @testset "Methionine RNA sequence is decoded as Methionine" begin
        @test rna"AUG" == ["Methionine"]
    end

    @testset "Phenylalanine RNA sequence is decoded as Phenylalanine" begin
        @test rna"UUU" == ["Phenylalanine"]
    end

    @testset "Other Phenylalanine RNA sequence is decoded as Phenylalanine" begin
        @test rna"UUC" == ["Phenylalanine"]
    end

    @testset "Leucine RNA sequence is decoded as Leucine" begin
        @test rna"UUA" == ["Leucine"]
    end

    @testset "Leucine RNA sequence is decoded as Leucine" begin
        @test rna"UUG" == ["Leucine"]
    end

    @testset "Serine RNA sequence is decoded as Serine" begin
        @test rna"UCUUCCUCAUCG" == ["Serine", "Serine", "Serine", "Serine"]
    end

    @testset "Tyrosine RNA sequence is decoded as Tyrosine" begin
        @test rna"UAUUAC" == ["Tyrosine", "Tyrosine"]
    end

    @testset "Cysteine RNA sequence is decoded as Cysteine" begin
        @test rna"UGUUGC" == ["Cysteine", "Cysteine"]
    end

    @testset "Tryptophan RNA sequence is decoded as Tryptophan" begin
        @test rna"UGG" == ["Tryptophan"]
    end

    @testset "STOP codon terminates translation" begin
        @test rna"UAA" == []
        @test rna"UAG" == []
        @test rna"UGA" == []
    end

    @testset "Sequence of two codons translates into proteins" begin
        @test rna"UUUUUU" == ["Phenylalanine", "Phenylalanine"]
    end

    @testset "Sequence of two different codons translates into proteins" begin
        @test rna"UUAUUG" == ["Leucine", "Phenylalanine"]
    end

    @testset "Translation stops if STOP codon appears in middle of sequence" begin
        @test rna"UGGUAG" == ["Tryptophan"]
    end

    @testset "Translation stops if STOP codon appears at beginning of sequence" begin
        @test rna"UAGUUUUGG" == []
    end

    @testset "Translation stops if STOP codon appears at end of two-codon sequence" begin
        @test rna"UGGUGUUAUUAAUGGUUU" == ["Tryptophan", "Cysteine", "Tyrosine"]
    end

    @testset "Non existent codon causes translation exception" begin
        @test_throws TranslationError rna"AAA"
    end

    @testset "Incomplete codon causes translation exception" begin
        @test_throws TranslationError rna"UGGU"
    end

    @testset "Incomplete RNA sequence can translate if given a stop codon" begin
        @test rna"UGGUAGUAAAA" == ["Tryptophan"]
    end
end