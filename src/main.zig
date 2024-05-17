const io = @import("io.zig");

export fn kernel_main() void {
    io.init();
    io.write("> ");


    while (true) {
        const char = io.readc();
        if (char == 13) {
            io.write("\n> ");
        } else {
            io.putc(char);
        }
    }
}
