function proteins(strand)
    codons = chunked(strand)
    results = []
    for codon in codons
        if !haskey(codon_to_protein, codon)
            throw(DomainError(codon, "Invalid codon"))
        end

        protein = codon_to_protein[codon]
        protein == "STOP" && return results
    
        push!(results, protein)
    end
    results
end

function chunked(strand)
    [strand[i:min(i + 3 - 1, end)] for i in 1:3:length(strand)]
end

codon_to_protein = Dict(
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UGG" => "Tryptophan",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
)
