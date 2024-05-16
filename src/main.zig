const io = @import("io.zig");



export fn kernel_main() void {
    io.init();
    io.write("hello");

    while (true) {
        io.putc(io.readc());
    }
}
