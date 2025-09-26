# Adapted from the C# implementation

const init_upper_mask::UInt8 = 0xFE

function get_transmit_sequence(message)
    transmit_seq = Vector{UInt8}()
    carry::UInt8 = 0
    upper_mask::UInt8 = init_upper_mask

    for message_byte in message
        if upper_mask == UInt8(0)
            # The carry now contains 7 bits. Flush it out.
            push!(transmit_seq, add_parity(carry))
            carry = UInt8(0)
            upper_mask = init_upper_mask
        end

        shift_places = trailing_zeros(upper_mask)
        current = (carry << (8 - shift_places)) | (message_byte >>> shift_places)
        push!(transmit_seq, add_parity(current))

        # Update parameters for next round
        carry = UInt8(message_byte & (~upper_mask))

        # Shorten the upper mask
        upper_mask <<= 1
    end

    if upper_mask != init_upper_mask
        last_group::UInt8 = UInt8(carry << count_ones(upper_mask))
        # We have left over carry data
        push!(transmit_seq, add_parity(last_group))
    end

    transmit_seq
end


add_parity(source::UInt8) =
    iseven(count_ones(source & 0x7F)) ? source << 1 : (source << 1) | 1


function decode_sequence(received_seq)
    length(received_seq) > 0 || return []

    decoded_message = Vector{UInt8}()
    byte_to_add::UInt8 = 0x00
    upper_mask::UInt8 = 0xFF
    for received_byte in received_seq
        if upper_mask == UInt8(0xFF)
            # This round is complete
            # Current byte too short
            byte_to_add = get_byte_data(received_byte)
            upper_mask = 0x80
            continue
        end

        current_byte_data::UInt8 = get_byte_data(received_byte)
        contribution::UInt8 = current_byte_data >>> trailing_zeros(upper_mask)
        push!(decoded_message, byte_to_add | contribution)
        
        # Update parameters for next round
        byte_to_add = (current_byte_data & ~(upper_mask | 0x01)) << count_ones(upper_mask)
        upper_mask = (upper_mask >> 1) | 0x80
    end

    decoded_message
end


function get_byte_data(data)
    iseven(count_ones(data::UInt8)) || error("Byte has incorrect parity") 
    UInt8(data & 0xFE)
end
