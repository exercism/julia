using Random

function generate_key()
    Random.randstring('a':'z', 100)
end

encode(plaintext, key, enc=true) =
    String([change(chr, inx, key, enc) for (inx, chr) in enumerate(collect(plaintext))])

decode(ciphertext, key) = encode(ciphertext, key, false)

function change(chr, inx, key, enc)
    keys = collect(key)
    while inx > length(keys)
        inx -= length(keys)
    end
    offset = enc ? keys[inx] - 'a' : 'a' - keys[inx]
    raw_int = Int(chr) + offset
    if raw_int > Int('z')
        raw_int -= 26
    end
    if  raw_int < Int('a')
        raw_int += 26
    end
    Char(raw_int)
end
