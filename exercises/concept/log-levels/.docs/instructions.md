# Instructions

In this exercise you'll be processing log-lines.

Each log line is a string formatted as follows: `"[<LEVEL>]: <MESSAGE>"`.

There are three different log levels:

- `INFO`
- `WARNING`
- `ERROR`

You have three tasks, each of which will take a log line and ask you to do something with it.

## 1. Get message from a log line

Implement the `message` function to return a log line's message:

```julia-repl
message("[ERROR]: Invalid operation")
# => "Invalid operation"
```

Any leading or trailing white space should be removed:

```julia-repl
message("[WARNING]:  Disk almost full\r\n")
# => "Disk almost full"
```

## 2. Get log level from a log line

Implement the `log_level` function to return a log line's log level, which should be returned in lowercase:

```julia-repl
log_level("[ERROR]: Invalid operation")
# => "error"
```

## 3. Reformat a log line

Implement the `reformat` function that reformats the log line, putting the message first and the log level after it in parentheses:

```julia-repl
reformat("[INFO]: Operation completed")
# => "Operation completed (info)"
```

## Note

All strings in this exercise are in English and limited to the ASCII character set.
Later Concepts will give a chance to work with Unicode characters.
