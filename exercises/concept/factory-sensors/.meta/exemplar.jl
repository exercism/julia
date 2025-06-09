humidity_level_ok(pct_humidity) = 
    pct_humidity <= 70 ? true : error("Humidity level too high: $pct_humidity%")

function temperature_ok(temperature)
    isnothing(temperature) && throw(ArgumentError("Sensor broken"))
    temperature > 500 && throw(DomainError(temperature, "Overheating!"))
    true
end

function monitor_the_machine(pct_humidity, temperature)
    humidity_level_ok(pct_humidity)
    temperature_ok(temperature)
    @info "Machine is running smoothly"
end



# This is what I failed to write working tests for
function old_monitor_the_machine(pct_humidity, temperature)
    try
        humidity_level_ok(pct_humidity) 
    catch e
        @error "Humidity level check failed: $pct_humidity%"
        rethrow()
    end

    try
        temperature_ok(temperature)
    catch e
        if e isa ArgumentError
            @error "Sensor is broken!"
        elseif e isa DomainError
            if temperature > 550
                @error "Dangerous overheating detected: $temperature °C" 
            else
                @warn "Overheating detected: $temperature °C"
            end
        end
        rethrow()
    end
    
    @info "Machine is running smoothly"
end
