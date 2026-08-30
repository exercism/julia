# function mmi(a, m)
#     a %= m
#     for x in 1:m
#         if (a * x) % m == 1
#             return x
#         end
#     1
# end

function translate(phrase, a, b, mode)
    m = 26
    gcd(a, m) == 1 || throw(ArgumentError("a and m must be coprime"))
    mode ∈ [0, 1] || throw(ArgumentError("invalid mode"))

    function process_char(c::Char)
        isdigit(c) && return c

        inx_c = c - 'a'
        new_c = mode == 0 ? a * inx_c + b : invmod(a, m) * (inx_c - b)
        Char(new_c % m + 'a')
    end

    chars = replace(lowercase(phrase), r"[^a-z0-9]" => "") |> collect
    process_char.(chars) |> String
end

chunk(s, n) = [s[i:min(i+n-1, lastindex(s))] for i in 1:n:length(s)]

function encode(plaintext, a, b)
    s = translate(plaintext, a, b, 0)
    join(chunk(s, 5), " ")
end

function decode(ciphertext, a, b)
    translate(ciphertext, a, b, 1)
end

#     new_c <- ifelse(mode == 0, a * inx_c + b, mmi(a, m) * (inx_c - b))
