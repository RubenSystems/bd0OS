const io = @import("io.zig");



export fn kernel_main() void {
    io.init();
    io.hr();
    io.write("\n\n>");
    var input_buffer: [100] u8 = undefined;
    var input_location: usize = 0;


    while (true) {
        const char = io.readc();
        if (char == 13) {
            // execute action
            io.write("\nINPUT: ");
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
