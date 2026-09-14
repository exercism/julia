# About

## Background

Most people who use a computer assume that computers will keep getting faster each year (though ["Moore's Law"][wiki-moore] referred to transistor density and cost, not speed).

For about two decades, it was possible to keep increasing the clock speed of CPUs.
The original IBM PC, released in 1981, was clocked at 4.77 MHz, and this gradually rose to the GHz range.

Then PC designers ran into physical limits, and maximum clock rates for a typical laptop have been approximately 3 GHZ at least since 2010.

Higher speeds greatly increase power consumption, leading to hot CPUs, noisy cooling fans, and terrible battery life (the author is old enough to have wasted his own money on some _really annoying_ hardware, back in the early 2000's).

Even the speed of light is a significant limitation. 
In a single clock cycle for a 3 GHz proecessor, light in vacuum travels only 10 cm (about 4 inches).
An electronic signal in a copper conductor might manage half that speed, so needs several clock cycles to cross the width of a laptop motherboard.

Therefore the focus shifted to designing multicore CPUs, which can execute multiple instructions simultaneously.

_Great!_
Except that few programmers knew how to use multiple cores, and mainstream programming languages of the time did little to make it easier.

## Approaches to concurrency and parallelism

Terminology in this area is confusing, even if used correctly (_and it is often misused_).

For our purposes:

- ***Concurrency*** means having multiple operations sharing a resource (such as a thread) by time-slicing.
  The CPU runs task A for a few milliseconds, then switches to task B, then back to A, giving the illusion of simultaneity.
- ***Parallelism*** means splitting the operations across genuinely separate threads, processes or even computers, before combining the results at the end.

Concurrency is conceptually simpler, and can be used with inherently single-threaded languages (JS, Ruby, Python up to at least v3.13).

As a simple but important example: a GUI program may need to run slow calculations, but also monitor user inputs.
Freezing the mouse and keyboard until the calculation finishes is not popular with users!

Parallelism looks like it should be somehow "better", but there is a price to pay (_quite a big price_):

- Software is harder to write, and _much_ harder to debug.
- There is always an overhead in managing parallel operations, so performance may not even be faster at runtime.

Because large-scale computations are a major use case for Julia, essentially all types of concurrency and parallelism are supported either by the Base language, or by commonly-used packages.

The [Julia manual][ref-parallel] lists four approaches:

1. Asynchronous tasks.
2. Multi-threading.
3. Distributed computing.
4. GPU computing.

The Exercism test runner supports asynchronous tasks and (fairly limited) multi-threading.

Distributed and GPU computing are out of our scope.
Also out of budget: they use serious hardware, and paying AWS for the servers would be impossibly expensive for a non-profit like Exercism.

## [Asynchronous tasks][ref-asynchronous]

### Tasks

We want multiple parts of our program to execute concurrently, and these "parts" are defined as [`Tasks`][ref-tasks].

Several languages have something similar to tasks, but the terminology varies: "symmetric coroutines", "lightweight threads", "cooperative multitasking", "one-shot continuations" are all roughly equivalent.
Julia tasks are particularly similar to goroutines in Go.

Creating a task is easiest with the [`@task`][ref-task-macro] macro and a zero-argument function, though a [`Task()`][ref-Task] constructor is also available.

```julia-repl
julia> t1 = @task begin; sleep(5); println("stopping"); end
Task (runnable) @0x00007c6963564b50
```

Importantly, this is just a task definition and nothing has started yet.
We can use [`schedule()`][ref-schedule] to add the task to the scheduler, so that it will be run as soon as free resources are available.

```julia-repl
julia> schedule(t1)
Task (runnable, started) @0x00007c6963564b50

julia> stopping
```

Note that `schedule()` returns immediately.
The task runs in the background, and we get the output some time later.

Because define-and-start-immediately is a common pattern, we can use the [`Threads.@spawn`][ref-spawn-macro] macro for convenience.

```julia-repl
using Base.Threads

julia> t2 = @spawn begin; sleep(5); println("t2 stopping"); end
Task (runnable, started) @0x00007c696230cb50

julia> t2 stopping
```

In older code and tutorials, you may see the [`@async`][ref-async-macro] macro do something similar.

```julia-repl
# deprecated approach!
julia> t3 = @async begin; sleep(5); println("t3 stopping"); end
Task (runnable, started) @0x00007c696230d000

julia> t3 stopping
```

However, recent versions of Julia advise against use of `@async` (for reasons that will be discussed in a later section on "stickiness").

Once a task is running, the Scheduler can suspend it at any time to run another task, then restart it at some later time.

At a low level, this uses the [`yieldto()`][ref-yieldto] function, but it is rarely necessary for you to call this directly.
Various events will cause the Scheduler to silently call `yieldto()`, including whenever the task has to wait: for user input, for a disk read, or similar.

The [`yield()`][ref-yield] function can be inserted at suitable points in your code, to help the scheduler interrupt at convenient moments: _between_ complex operations, rather than in the middle of them.

Some useful information functions include:

- [`current_task()`][ref-current_task] to get a reference to the task now active.
- [`istaskstarted()`][ref-istaskstarted] and [`istaskdone()`][ref-istaskdone] to check if the task has started/finished.
- [`task_local_storage()`][ref-task_local_storage] to get or set a value in the task's local (thread-safe) [key-value store][web-tls].

If you need to wait for a task `t` to finish and exit before continuing, just use [`wait(t)`][ref-wait].

```julia-repl
julia> using Base.Threads

julia> t4 = @spawn begin; sleep(5); println("stopping"); end; wait(t4)
stopping

# no new julia> prompt until the task finishes
```

If a task `t` returns a result, `t.result` will contain that value _after_ task completion.
Until then, it contains [`nothing`][concept-nothingness].

```julia-repl
julia> t5 = @spawn begin; sleep(10); return 42; end
Task (runnable, started) @0x0000786c6e270e20

julia> t5.result  # no result yet

julia> t5.result  # t5 has finished
42
```

Instead, we could use [`fetch()`][ref-task-fetch], which waits for the task to complete before returning the result.

```julia-repl
julia> t5 = @spawn begin; sleep(10); return 42; end
Task (runnable, started) @0x0000786c6e271b40

julia> fetch(t5)  # waits at this point
42
```

To wait for a collection of tasks to finish, we can wrap them in a [`@sync`][ref-sync-macro] macro.

```julia-repl
julia> facts = zeros(Int, 15); # => 15-element Vector{Int64}

julia> @sync for n in 1:15; sleep(0.1); facts[n] = factorial(n); end

julia> facts
15-element Vector{Int64}:
             1
             2
             6
            24
           120
           720
          5040
         40320
        362880
       3628800
      39916800
     479001600
    6227020800
   87178291200
 1307674368000
```

Tasks are lightweight, and there is little overhead in creating large numbers of them: maybe tens of thousands.
Of course, they then have to queue for an opportunity to run, but the Julia scheduler can easily handle this.

## [Multi-Threading][ref-multithreading]

Tasks are defined by Julia, but [threads][wiki-thread] are provided by the operating system.

The desired number of threads must be specified when starting Julia from the command line.

```bash
$ julia --threads 4 # or -t 4 for brevity
```

Alternatively, use `--threads auto`.
Then the OS will choose a suitable number, based on the hardware: typically the number of CPU cores.

The available options are more complicated than this, including use of environment variables, and liable to change in future Julia releases.
See the [manual][ref-starting-threads] for up-to-date details.

To get the actual number of threads (more specifically, _worker threads_) from within code, we have the very useful [`Threads`][ref-Threads-module] module.

```julia-repl
julia> using Base.Threads

julia> nthreads() # on the author's PC, with -t auto
16
```

Creating larger numbers of threads is not forbidden, but probably not useful: matching thread numbers to the available hardware is preferred.

Unlike lightweight tasks, threads are an operating system resource, and context-switching between them has a significant overhead.

### Sticky and non-sticky tasks

When you start a task on a thread, will it always run on that thread?

_It depends_, but on recent versions of Julia probably _no_: and you should generally aim for it to be _no_.

Each task `t` has a `sticky` bit, controlling how the Scheduler handles it.

If `t.sticky == true` (the default, for historical reasons), a task started on a particular thread will only ever run on that same thread, no matter how many times it is interrupted and restarted.

This prevents the Scheduler making most efficient use of the available hardware, so setting `t.sticky = false` is preferred.

This can be done manually for any task, but in practice we just use [`Threads.@spawn`][ref-spawn-macro] to create the task, instead of the deprecated [`@async`][ref-async-macro].

```julia-repl
# Recommended
julia> t2 = @spawn begin; sleep(10); end
Task (runnable, started) @0x00007c6963bc63b0

julia> t2.sticky
false

# Deprecated
julia> t3 = @async begin; sleep(10); end
Task (runnable, started) @0x00007c69623ef3a0

julia> t3.sticky
true
```

A non-sticky task can be restarted on any available thread, which is good for performance.

One related warning: never rely on the [`threadid`][ref-threadid] to identify your task, as this can change unpredictably at any time.

~~~~exercism/note
Some operations may pass the calculation to libraries written in C, C++ or Fortran, which implement their own multi-threading.

In particular, linear algebra operations are likely to use [`OpenBLAS`][wiki-openblas], which will automatically distribute the calculation across all your CPU cores in the background.

Try doing a big matrix multiplication, and watch your OS's CPU meter as it runs.

[wiki-openblas]: https://en.wikipedia.org/wiki/OpenBLAS
~~~~

## Channels

When multiple tasks are running, they often need a way to communicate asynchronously.

In Julia, a [`Channel`][ref-channels] is a first-in, first-out ([FIFO][wiki-FIFO]) queue which can be written and read by multiple tasks.

As a mental model, you can also think of it as a pipe, with a read end and a write end.

If you are familiar with Go, Julia's tasks and channels are quite similar to Go's (very popular) goroutines and channels.

There are two types of constructor for `Channel`.

[Firstly][ref-Channel-size], optionally specify a type (which defaults to `Any`), and optionally a buffer size (which defaults to zero, creating an unbuffered channel).

```julia-repl
julia> chn1 = Channel(32)
Channel{Any}(32) (empty)

julia> chn2 = Channel{Int}()
Channel{Int64}(0) (empty)

julia> put!(chn1, 42)
42

julia> put!(chn1, "fortytwo")
"fortytwo"

# status of buffered channel
julia> chn1
Channel{Any}(32) (2 items available)

# DON'T do this in the REPL with an unbuffered channel
julia> put!(chn2, 5)
# the thread on which the REPL runs is now blocked, 
# and you lost control of it 
# (hit Ctrl-C several times, quickly, to recover)
```

[Alternatively][ref-Channel-func], pass a function as the argument.
Julia will create a new task from the function and bind it to the channel.

The supplied function must take exactly one argument: the bound channel.

```julia-repl
julia> function producer(c::Channel)
           put!(c, 42)
           put!(c, "ending")
       end
producer (generic function with 1 method)

julia> chn3 = Channel(producer)
Channel{Any}(0) (1 item available)

julia> take!(chn3)
42

julia> take!(chn3)
"ending"

julia> take!(chn3)
ERROR: InvalidStateException: Channel is closed.
```

A function-derived of channel will auto-close when the function exits.
In real use, 

Once a channel exists, tasks can write to it with [`put!()`][ref-put], adding an entry, and read from it with [`take!()`][ref-take], removing an entry.

An alternative read function is [`fetch()`][ref-fetch], which returns a copy of the entry but _does not_ remove it from the channel.

There are various information functions to determine the state of a channel.

- [`isfull()`][ref-isfull]: the buffer is at capacity, so `put!()` operations will block and wait until a write is possible.
- [`isready()`][ref-isready]: the channel has an entry available for read.
- [`isopen()`][ref-isopen]: the channel is available to `put!()` a new entry (or queue it is the buffer is full).

Only bound channels will auto-close: those created with the second type of constructor, or those where you [`bind()`][ref-bind] a task after construction.
Use [`close()`][ref-close] to remove other types of channel.

It is possible to iterate over a channel to get all available entries.

```julia-repl
# the producer() funtcion was defined in a previous example

julia> for entry in Channel(producer); println(entry); end
42
ending
```

## Race conditions and deadlocks

Tasks running on one or more threads are in a _shared memory_ environment, and can all read the same variables in the outer scope.

So far, so good.
The (_big!_) problem is that the tasks can  all _write_ to the same variables, and this can lead to dangerously non-deterministic results.

Suppose you have 4 tasks, all performing some calculation and updating a variable with the result at the end.

_Which task will finish first? Which one last?_

You have no way of knowing in advance!
Worse, it will probably be different each time you run the program.

Debugging this is going to be... _challenging_.

Problems which depend on the order in which asynchronous code runs are often called "race conditions": the results depend unpredictably on when each task crosses the finish line.

This has been a big area of computer science research over the past 30+ years, many potential solutions have been invented, and Julia supports many of them.

We talk about code that avoids race conditions (and related problems) as being "thread-safe".

### Write data to separate variables

At its simplest, this can mean that each task gets its own index into a results vector, and writes _only_ to that element.

We already saw this in an earlier example.

There will then be some sort of `reduce` operation once all tasks finish.

```julia-repl
julia> facts = zeros(Int, 15); # => 15-element Vector{Int64}

julia> @sync for n in 1:15; sleep(0.1); facts[n] = factorial(n); end

julia> facts
15-element Vector{Int64}:
             1
             2
             6
            24
           120
           720
          5040
         40320
        362880
       3628800
      39916800
     479001600
    6227020800
   87178291200
 1307674368000

# aggregate to a single result
julia> sum(facts)
1401602636313
```

### Use channels

A Julia channel is thread-safe, so any number of tasks can write results to each channel.

For thread-safety, only a _single_ task should be permitted to read the results and aggregate them.

```julia-repl
# TODO example
```

### Use locks

For added debugging "fun", imagine that your task wants to increment a shared value.

We can write this simply as `v += n`, but that hides the three underlying operations.

1. Read the old value
2. Perform a calculation on it
3. Write the new value

But in the middle of this, another task can _change_ the old value, and you are now working on stale data.

One way to handle this is with the use of [locks][wiki-locks], declaring "this variable is mine, nothing else can touch it until I am finished".

Some other languages (rarely Julia) refer to this as [mutual-exclusion][wiki-mutual-exclusion], or `mutex` for short.

```julia-repl
# TODO example
```

Making sure that you release the lock is entirely your responsibility (though Julia has syntax that can help).

A worst-case scenario is when task A is waiting for task B to release a lock, but task B is simultaneously waiting for task A.

[Deadlock][wiki-deadlock] is the correct name for this, and it makes programmers very nervous.

### Use Atomic variables

TODO

## [Distributed Computing][ref-distributed]

None of this is available within Exercism, but we will briefly summarize some of the things you might want to try on your own computer.

TODO

## Glossary

The LessWrong website has a [useful summary][web-lesswrong] of Julia threads, including a glossary of relevant terms.

It is copied here, with thanks.

- `Task(my_function)` create a Task from a callable function with no arguments.
- `@task` create a Task from an arbitrary Julia expression
- `schedule(task::Task)` schedule task to be run
- `task.sticky` if true, task can only be run on the same hardware thread where schedule was called. If false, it can be assigned to any thread on the scheduler. The current recommendation is to use non-sticky tasks almost all the time, but tasks are sticky by default for historical reasons.
- `Threads.@spawn` create and immediately schedule a non-sticky Task. This gives the Julia scheduler freedom to run the Task in the way that it thinks is optimal
- `@async` (deprecated) create and immediately schedule a sticky task
- `Threads.@threads` (deprecated) run a for loop in parallel
- `wait(task::Task)` waits for a task to complete
- `task.result` once the task is done, contains the output. Contains nothing otherwise
- `fetch(task::Task)` : wait for the task, then return its result value
- `@sync` use this before an expression that creates multiple tasks, and it will wait until all those tasks are done.
- `Channel` "a waitable first-in first-out queue which can have multiple tasks reading from and writing to it". Channels are a robust way of communicating between tasks. If you're familiar with Go, you use Tasks and Channels in Julia the way you use Goroutines and Channels in Go.
- `put!(channel::Channel, value)` append value to channel, blocking if it's full
- `take!(channel::Channel)` return the next available value from channel, blocking if it's empty

[wiki-moore]: https://en.wikipedia.org/wiki/Moore%27s_law
[wiki-FIFO]: https://en.wikipedia.org/wiki/FIFO_(computing_and_electronics)
[wiki-thread]: https://en.wikipedia.org/wiki/Thread_(computing)
[wiki-locks]: https://en.wikipedia.org/wiki/Lock_(computer_science)
[wiki-mutual-exclusion]: https://en.wikipedia.org/wiki/Mutual_exclusion
[wiki-deadlock]: https://en.wikipedia.org/wiki/Deadlock_(computer_science)
[ref-parallel]: https://docs.julialang.org/en/v1/manual/parallel-computing/
[ref-asynchronous]: https://docs.julialang.org/en/v1/manual/asynchronous-programming/
[ref-multithreading]: https://docs.julialang.org/en/v1/manual/multi-threading/
[ref-distributed]: https://docs.julialang.org/en/v1/manual/distributed-computing/
[ref-tasks]: https://docs.julialang.org/en/v1/manual/asynchronous-programming/#Basic-Task-operations
[ref-channels]: https://docs.julialang.org/en/v1/manual/asynchronous-programming/#Communicating-with-Channels
[ref-schedule]: https://docs.julialang.org/en/v1/base/parallel/#Base.schedule
[ref-task-macro]: https://docs.julialang.org/en/v1/base/parallel/#Base.@task
[ref-async-macro]: https://docs.julialang.org/en/v1/base/parallel/#Base.@async
[ref-yieldto]: https://docs.julialang.org/en/v1/base/parallel/#Base.yieldto
[ref-Task]: https://docs.julialang.org/en/v1/base/parallel/#Core.Task
[ref-Threads-module]: https://docs.julialang.org/en/v1/base/multi-threading/#lib-multithreading
[ref-starting-threads]: https://docs.julialang.org/en/v1/manual/multi-threading/#Starting-Julia-with-multiple-threads
[ref-spawn-macro]: https://docs.julialang.org/en/v1/base/multi-threading/#Base.Threads.@spawn
[ref-Channel-size]: https://docs.julialang.org/en/v1/base/parallel/#Base.Channel
[ref-Channel-func]: https://docs.julialang.org/en/v1/base/parallel/#Base.Channel-Tuple{Function}
[ref-put]: https://docs.julialang.org/en/v1/base/parallel/#Base.put!-Tuple{Channel,%20Any}
[ref-take]: https://docs.julialang.org/en/v1/base/parallel/#Base.take!-Tuple{Channel}
[ref-fetch]: https://docs.julialang.org/en/v1/base/parallel/#Base.fetch-Tuple{Channel}
[ref-isfull]:https://docs.julialang.org/en/v1/base/parallel/#Base.isfull-Tuple{Channel}
[ref-isready]: https://docs.julialang.org/en/v1/base/parallel/#Base.isready-Tuple{Channel}
[ref-isopen]: https://docs.julialang.org/en/v1/base/parallel/#Base.isopen-Tuple{Channel}
[ref-bind]: https://docs.julialang.org/en/v1/base/parallel/#Base.bind-Tuple{Channel,%20Task}
[ref-close]: https://docs.julialang.org/en/v1/base/parallel/#Base.close-Tuple{Channel}
[ref-threadid]: https://docs.julialang.org/en/v1/base/multi-threading/#Base.Threads.threadid
[ref-yield]: https://docs.julialang.org/en/v1/base/parallel/#Base.yield
[ref-current_task]: https://docs.julialang.org/en/v1/base/parallel/#Base.current_task
[ref-istaskstarted]: https://docs.julialang.org/en/v1/base/parallel/#Base.istaskstarted
[ref-istaskdone]: https://docs.julialang.org/en/v1/base/parallel/#Base.istaskdone
[ref-task_local_storage]: https://docs.julialang.org/en/v1/base/parallel/#Base.task_local_storage-Tuple{Any}
[ref-wait]: https://docs.julialang.org/en/v1/base/parallel/#Base.wait
[ref-sync-macro]: https://docs.julialang.org/en/v1/base/parallel/#Base.@sync
[ref-task-fetch]: https://docs.julialang.org/en/v1/base/parallel/#Base.fetch-Tuple{Task}
[web-tls]: https://juliafolds2.github.io/OhMyThreads.jl/stable/literate/tls/tls/#TLS
[web-lesswrong]: https://www.lesswrong.com/posts/kPnjPfp2ZMMYfErLJ/julia-tasks-101
[concept-nothingness]: https://exercism.org/tracks/julia/concepts/nothingness
