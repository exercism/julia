function proteins(strand)
    results = []
    for codon in join.(Iterators.partition(strand, 3))
        if !haskey(MAPPINGS, codon)
            throw(DomainError("Invalid codon"))
        end

        protein = MAPPINGS[codon]
        if protein == "STOP"
            return results
        end

        push!(results, protein)
    end

    results
end

MAPPINGS = Dict("AUG" => "Methionine",
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
                "UGA" => "STOP")
