# Aiming to solve this early concept exercise without regex knowledge

split_msg(msg) = split(msg, ": ")

message(msg) = strip(split_msg(msg)[2])

function log_level(msg)
    raw = lowercase(split_msg(msg)[1])
    raw[2:(end-1)]
end

reformat(msg) = "$(message(msg)) ($(log_level(msg)))"
