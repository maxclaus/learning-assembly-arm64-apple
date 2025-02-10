## DEBUGGING

Learning how to debug a Assembly program makes development more enjoyable and simpler to understand by focusing on each instruction individually at a time.

This [video][lldb_debugger_video] has a good introduction to [LLDB Debugger](https://lldb.llvm.org/), it is debugging C++ program but it still helpful: Learn the lldb debugger basics in 11 minutes | 2021 (Also works on M1 Apple Silicon).

This is how I started the debugger for an Assembly program:

- Build object code files using as with -g argument which includes debugging information in the output object file.
- Builds the executable file based on the previous object files (nothing different the usual in this part).
- Start LLDB debugger for that program `lldb ./<program_executable>`
- Add a breaking point `b <program_source_file>:<line_number>`.
- Run the program run by executing the program binary.

These are all the commands I used on debugging Assembly programs:

- `lldb ./<program_executable>`: Start debugger for a program
- `b <program_source_file>:<line_number>`: Add breakpoint to a specific line (reason why we need to include the source code). Another more verbose option breakpoint set --file <program_source_file> --line <line_number>
- `b <label*name>`: Add a break point to label. If the label starts with \* though, you need to omit the \_.
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
- `p`: Print a variable or expression as decimal (`p $X0`).
- `p/<format>`: output formats.
- `p/x`: Print a variable or expression as hexadecimal (`p/x $X0`).
- `p/d`: Print a variable or expression as decimal (`p/d $X0`).
- `p/s`: Print a variable or expression as string (`p/s $X0`).
- `x (abbreviation for memory read)`: Read from the memory of the current target process. Example reading input label with "string" content with 4 bytes x -s 4 -f c &input.
- `target create <program_executable>`: Relaunch program.
- `gui`: Graphical user interface.
- `help`
- `help <command>`
- `q, quit`: Quit program.

[lldb_debugger_video]: https://www.youtube.com/watch?v=v_C1cvo1biI
