using Test

include("protein-translation.jl")

@testset "Protein Translation" begin

    @testset "Empty RNA sequence returns an empty list" begin
        @test rna_to_amino_acids("") == []
    end

    @testset "Methionine RNA sequence is decoded as Methionine" begin
        @test rna_to_amino_acids("AUG") == ["Methionine"]
    end

    @testset "Phenylalanine RNA sequence is decoded as Phenylalanine" begin
        @test rna_to_amino_acids("UUUUUC") == ["Phenylalanine", "Phenylalanine"]
    end

    @testset "Leucine RNA sequence is decoded as Leucine" begin
        @test rna_to_amino_acids("UUA") == ["Leucine"]
    end

    @testset "Leucine RNA sequence is decoded as Leucine" begin
        @test rna_to_amino_acids("UUG") == ["Leucine"]
    end

    @testset "Serine RNA sequence is decoded as Serine" begin
        @test rna_to_amino_acids("UCUUCCUCAUCG") == ["Serine", "Serine", "Serine", "Serine"]
    end

    @testset "Tyrosine RNA sequence is decoded as Tyrosine" begin
        @test rna_to_amino_acids("UAUUAC") == ["Tyrosine", "Tyrosine"]
    end

    @testset "Cysteine RNA sequence is decoded as Cysteine" begin
        @test rna_to_amino_acids("UGUUGC") == ["Cysteine", "Cysteine"]
    end

    @testset "Tryptophan RNA sequence is decoded as Tryptophan" begin
        @test rna_to_amino_acids("UGG") == ["Tryptophan"]
    end

    @testset "STOP codon terminates translation" begin
        @test rna_to_amino_acids("UAA") == []
        @test rna_to_amino_acids("UAG") == []
        @test rna_to_amino_acids("UGA") == []
    end

    @testset "Sequence of two codons translates into proteins" begin
        @test rna_to_amino_acids("UUUUUUUGA") == ["Phenylalanine", "Phenylalanine"]
    end

    @testset "Sequence of two different codons translates into proteins" begin
        @test rna_to_amino_acids("UUAUUUUAG") == ["Leucine", "Phenylalanine"]
    end

    @testset "Translation stops if STOP codon appears in middle of sequence" begin
        @test rna_to_amino_acids("UGGUAAUGCAUG") == ["Tryptophan"]
    end

    @testset "Translation stops if STOP codon appears at beginning of sequence" begin
        @test rna_to_amino_acids("UAGUAUUCGUCAUCU") == []
    end

    @testset "Translation stops if STOP codon appears at end of two-codon sequence" begin
        @test rna_to_amino_acids("UGGUGUUGA") == ["Tryptophan", "Cysteine"]
    end

    @testset "Non existent codon causes translation exception" begin
        @test_throws ArgumentError rna_to_amino_acids("AAA")
    end

    @testset "Incomplete codon causes translation exception" begin
        @test_throws ArgumentError rna_to_amino_acids("UGUU")
    end

    @testset "Incomplete RNA sequence can translate if given a stop codon" begin
        @test rna_to_amino_acids("UGGUGAUG") == ["Tryptophan"]
    end

    # Bonus
    if isdefined(@__MODULE__, Symbol("@rna_str"))
        @eval @testset "Bonus: rna string macro" begin
            @test rna"AUGUUUUUAUGGUACUAG" == ["Methionine", "Phenylalanine", "Leucine", "Tryptophan", "Tyrosine"]
        end
    end

end
