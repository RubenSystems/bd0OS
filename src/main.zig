const io = @import("io.zig");



export fn kernel_main() void {
    io.write("hello");

    while (true) {
        io.putc(io.readc());
    }
}
