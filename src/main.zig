const io = @import("io.zig");

/// # Safety
/// - The buffers must be the same length
fn eq(comptime T: type, lhs: []const T, rhs: []const T) bool {
    for (0..lhs.len) |i| {
        if (lhs[i] != rhs[i]) return false;
    }
    return true;
}

export fn kernel_main() void {
    io.init();
    io.hr(100);
    io.write("\n\n> ");
    var input_buffer: [100]u8 = undefined;
    var input_location: usize = 0;

    while (true) {
        const char = io.readc();
        if (char == 13) {
            // execute action
            io.write("\n\nINPUT: ");
            for (0..input_location) |i| {
                io.putc(input_buffer[i]);
            }
            input_location = 0;
            io.write("\n> ");
        } else {
            io.putc(char);
            input_buffer[input_location] = char;
            input_location += 1;
        }
    }
}
