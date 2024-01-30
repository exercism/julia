codon_protein_dict = Dict(
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

struct TranslationError <: Exception
    message::String
end

macro rna_str(str)
    rna_translator(str)
end

function rna_translator(str)
    n = 3
    result = []
    for i=1:n:length(str)
        substring = try
            SubString(str, i, i+n-1)
        catch
            throw(TranslationError("invalid rna string"))
        end
        protein = string_to_protein(substring)
        protein == "STOP" && break
        push!(result, protein)
    end
    result
    
end


function string_to_protein(str)
    p = get(codon_protein_dict, str, nothing)
    p === nothing && throw(TranslationError("invalid codon"))
    return p
end
