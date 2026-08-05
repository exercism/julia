function ciphertext(plaintext)
    normalized = replace(lowercase(plaintext), r"[^a-z0-9]" => "")
    normalized == "" && return ""

    # Julia matrices are column-major
    # we will need a transpose to match the problem specification
    r = normalized |> length |> sqrt |> ceil |> Int
    c = (length(normalized) / r) |> ceil |> Int
    normalized *= repeat(" ", r * c - length(normalized))
    matrix_form = reshape(collect(normalized), (r, c)) |> transpose
    join(join.(eachcol(matrix_form)), " ")
end
