////////////////////////////////////////////////////////////////////////////////
// ┌─────────────────────────────────────────────────────────────────────────┐//
// │                                                                         │//
// │                                                                         │//
// │  Base Delta Zero Operating System Entry Point                           │//
// │                                                                         │//
// │                                                                         │//
// └─────────────────────────────────────────────────────────────────────────┘//
////////////////////////////////////////////////////////////////////////////////

const io = @import("io.zig");



export fn kernel_main() void {
    io.init();
    io.write("\n\n> welcome to bd0");
    io.write("\n> current exception level");
    io.putc(@intCast(io.get_exception_level() + 48));
    while (true) {
        const char = io.readc();
        io.putc(char);
    }
}
