# Base Delta 0 Operating System

BD0 is a single-user operating system for headless environments, such as
web servers. It aims to strike a balance between ease-of-use and 
performance that is more skewed to the performance side than other OSs.
Process-level and user-level security are non-concerns for BD0, so it
might not be so clear exactly what the operating system is doing. Here
are some things we want BD0 to be able to do:

- Configurable, predictable **scheduling** for multi-process
   environments.
- The concept of a **process** (or thread) and tools for
  starting/stopping processes.
- A fast **filesystem** (no privilege switches needed!).
- A big library of useful stuff, like a TCP/IP suite and a malloc() 
  suite.
- Hardware support for fancy peripherals (like GPUs and whatnot)...

## User Guide

You will need an aarch64 assembler, a Zig compiler and Qemu and also 
perhaps some other things. I'm sure you can figure it out.

To build/run etc.

```makefile
make build $(cat <env>.env)
make run
```

Replace `<env>` with either `macos` or `linux-gnu` depending on what you
use. 

## Ubuntu

```sh
sudo apt install qemu-system-aarch64
sudo apt update && sudo apt install gcc-13 gcc-13-aarch64-linux-gnu
```