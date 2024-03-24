- `lldb ./<program_executable>`: Start debugger for a program
- `b <program_source_file>:<line_number>`: Add breakpoint to a specific line ([reason why we need to include the
  source code](https://stackoverflow.com/a/65767401/1050818)).
- `run`: Launch the program within the debugger
- `c`: Continue execution.
- `n, next`: Step over.
- `s, step`: Step into.
- `bt`: Show the current thread's call stack. Any numeric argument displays at most that many frames. The argument 'all' displays all threads.
- `finish`: Finish executing the current stack frame and stop after returning.
- `re, register`: Commands to access registers for the current thread and stack frame.
- `list`: List relevant source code using one of several shorthand formats.
- `register read`: Print general purpose registers
- `register read --all`: Print all registers
- `register read <register>`: Print the value for a register.
- `target create <program_executable>`: Relaunch program.
- `gui`: Graphical user interface.
- `help`
- `help <command>`
- `q, quit`: Quit program.

[Learn the lldb debugger basics in 11 minutes | 2021 (Also works on M1 Apple Silicon)](https://www.youtube.com/watch?v=v_C1cvo1biI)
