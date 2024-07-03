function proteins(strand)
    # chunk strands into groups of up to three
        codons = chunked(strand)
        proteins = []
        for codon in codons
            if !haskey(codon_to_protein, codon)
                throw(DomainError(codon, "Invalid codon"))
            end
    
            protein = codon_to_protein[codon]
            protein == "STOP" && return proteins
        
            push!(proteins, protein)
        end
        proteins
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
