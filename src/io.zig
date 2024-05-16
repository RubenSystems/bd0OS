const registers = @import("registers.zig");

fn mmio_write(register: u32, data: u32) void {
    const regv = registers.MMIO_BASE + register;
    const ptr: *volatile u32 = @ptrFromInt(regv);
    ptr.* = data;
}


fn mmio_read(register: u32) u32 {
    const offset = registers.MMIO_BASE + register;
    const ptr: *volatile u32 = @ptrFromInt(offset);
    return ptr.*;
}

pub fn putc(c: u8) void {
    while (mmio_read(registers.UART0_FR) & (1 << 5) > 0) {}
    mmio_write(registers.UART0_DR, c);
}

pub fn readc() u8 {
    while (mmio_read(registers.UART0_FR) & (1 << 4) > 0) {}
    return @intCast(mmio_read(registers.UART0_DR));
}

pub fn write(s: [] const u8) void {
    for (s) |c| {
        putc(c);
    }
}
