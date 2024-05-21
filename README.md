# Base Delta 0 Operating System

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