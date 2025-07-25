# Instructions

Elena is the new quality manager of a newspaper factory. 
As she has just arrived in the company, she has decided to review some of the processes in the factory to see what could be improved. 
She found out that technicians are doing a lot of quality checks by hand. She sees there is a good opportunity for automation and asks you, a freelance developer, to develop a piece of software to monitor some of the machines.

## 1. Check the humidity level of the room

Your first mission is to write a piece of software to monitor the humidity level of the production room. There is already a sensor connected to the software of the company that returns periodically the humidity percentage of the room.

You need to implement a function in the software that will throw an error if the humidity percentage is too high.
If the humidity is at an acceptable level, a info log will be added.
The function should be called `humiditycheck` and take the humidity percentage as an argument.

You should halt with an ErrorException (the exact message is not important, but must contain the measured humidity level) if the percentage exceeds 70%. 
Otherwise, add an Info log, with the message `"humidity level check passed: h%"`, where `h` is the humidity percentage.

```julia-repl
julia> humiditycheck(60)
[ Info: humidity level check passed: 60%
```

```julia-repl
julia> humiditycheck(100)
ERROR: humidity check failed: 100%
```

## 2. Check for overheating

Elena is very pleased with your first assignment and asks you to deal with the monitoring of the machines' temperature.
While chatting with a technician, Greg, you are told that if the temperature of a machine exceeds 500°C, the technicians start worrying about overheating.

The machine is equipped with a sensor that measures its internal temperature.
You should know that the sensor is very sensitive and often breaks.
In this case, the technicians will need to change it.

Your job is to implement a function `temperaturecheck` that takes the temperature as an argument and either adds a log if all is well or throws an error if the sensor is broken or if the machine starts overheating.
Knowing that you will later need to react differently depending on the error, you need a mechanism to differentiate the two kinds of errors.

- If the sensor is broken, the temperature will be `nothing`.
  In this case, you should halt with an `ArgumentError` (the message is not important).
- When the sensor is working, if the temperature exceeds 500°C, you should throw a `DomainError` that includes the measured temperature.
- Otherwise, all is well, so add an Info log with the message `"temperature check passed: t °C"`, where `t` is the temperature.

```julia-repl
julia> temperaturecheck(nothing)
ERROR: ArgumentError: sensor is broken

julia> temperaturecheck(800)
ERROR: DomainError with 800:
"overheating detected"

julia> temperaturecheck(500)
[ Info: temperature check passed: 500 °C
```

## 3. Define custom error

For the next task, you will need to define a more general, catch-all error.
The implementation details are not important beyond it being an error and the name being `MachineError`.
You can feel free to include fields and messages as you find helpful.

## 4. Monitor the machine

Now that your machine can detect errors and you have a custom machine error, you add a wrapper function that can report how everything is working.
Beyond returning the logs from the previous functions, this wrapper will also need to add logs depending on any type(s) of failure(s) that occur.

- Check the humidity and temperature.
- If the humidity check throws an `ErrorException`, an Error log should be added with the message, `"humidity level check failed: h%"`, where `h` is the humidity percentage.
- If the temperature check throws an `ArgumentError`, a Warn log should be added with the message `"sensor is broken"`.
- If the temperature check throws a `DomainError`, an Error log should be added with the message, `"overheating detected: t °C"`, where `t` is the temperature.
- If either or both of the checks fail, a single `MachineError` should be thrown after the logs are added.
- If all is well, only the logs from `humiditycheck` and `temperaturecheck` will be added.

Implement a function `machinemonitor()` that takes humidity and temperature as arguments.

```julia-repl
julia> machinemonitor(42, 450)
[ Info: humidity level check passed: 42%
[ Info: temperature check passed: 450 °C

julia> machinemonitor(42, 550)
[ Info: humidity level check passed: 42%
┌ Error: overheating detected: 550 °C
└ @ Main # output truncated

Error: MachineError

julia> machinemonitor(82, 521)
┌ Error: humidity level check failed: 82%
└ @ Main # output truncated
┌ Error: overheating detected: 521 °C
└ @ Main # output truncated

Error: MachineError

julia> machinemonitor(42, nothing)
[ Info: humidity level check passed: 42%
┌ Warning: sensor is broken
└ @ Main # output truncated

Error: MachineError
```
