# Instructions

Elena is the new quality manager of a newspaper factory. 
As she has just arrived in the company, she has decided to review some of the processes in the factory to see what could be improved. 
She found out that technicians are doing a lot of quality checks by hand. She sees there is a good opportunity for automation and asks you, a freelance developer, to develop a piece of software to monitor some of the machines.

## 1. Monitor the humidity level of the room

Your first mission is to write a piece of software to monitor the humidity level of the production room. There is already a sensor connected to the software of the company that returns periodically the humidity percentage of the room.

You need to implement a function in the software that will throw an error if the humidity percentage is too high.
The function should be called `humidity_level_ok` and take the humidity percentage as a parameter.

You should halt with an ErrorException (the exact message is not important, but must contain the measured humidity level) if the percentage exceeds 70%. 
Otherwise, return `true` to confirm the measurement is good.

```julia-repl
julia> humidity_level_ok(60)
true
```

```julia-repl
julia> humidity_level_ok(100)
ERROR: Humidity level too high: 100%
```

## 2. Detect overheating

Elena is very pleased with your first assignment and asks you to deal with the monitoring of the machines' temperature.
While chatting with a technician, Greg, you are told that if the temperature of a machine exceeds 500°C, the technicians start worrying about overheating.

The machine is equipped with a sensor that measures its internal temperature.
You should know that the sensor is very sensitive and often breaks.
In this case, the technicians will need to change it.

Your job is to implement a function `temperature_ok` that takes the temperature as a parameter and throws an error if the sensor is broken or if the machine starts overheating.
Knowing that you will later need to react differently depending on the error, you need a mechanism to differentiate the two kinds of errors.

- If the sensor is broken, the temperature will be `nothing`.
  In this case, you should halt with an `ArgumentError` (the message is not important).
- When everything works, if the temperature exceeds 500°C, you should throw a `DomainError` that includes the measured temperature.
- Otherwise, return `true` to confirm the measurement is good.

```julia-repl
julia> temperature_ok(nothing)
ERROR: ArgumentError: Sensor broken

julia> temperature_ok(800)
ERROR: DomainError with 800:
Overheating!

julia> temperature_ok(500)
true
```

## 3. Monitor the machine

Now that your machine can detect errors, you add a wrapper function that can report if everything is good.

- Check the humidity and temperature, throwing errors as in previous tasks if neccesary.
- If everything is good, add an Info log to say the tests ran successfully. The message should be (exactly) "Machine is running smoothly".

Implement a function `monitor_the_machine()` that takes humidity and temperature as arguments.

```julia-repl
julia> monitor_the_machine(42, 450)
[ Info: Machine is running smoothly

julia> monitor_the_machine(42, 550)
ERROR: DomainError with 550:
Overheating!
```
