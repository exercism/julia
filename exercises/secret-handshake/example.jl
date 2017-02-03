function secret_handshake(code::Integer)
    # NOTE: Handle wrong codes
    # code < 0 && error("Invalid secret handshake code")
    # NOTE: Handle common actions
    masks = [(1, "wink"), (2, "double blink"),
             (4, "close your eyes"), (8, "jump")]
    actions = map(x->code&x[1]==x[1]&&x[2], masks)
    filter!(x->x!=false, actions)
    # NOTE: Handle reversing bitmask
    code&16==16 && reverse!(actions)
    actions
end
