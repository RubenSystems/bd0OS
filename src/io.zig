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

pub fn init() void {
    mmio_write(registers.UART0_CR, 0x00000000);
    mmio_write(registers.GPPUD, 0x00000000);
    // delay
    mmio_write(registers.GPPUDCLK0, (1 << 14) | (1 << 15));
    // delay
    mmio_write(registers.GPPUDCLK0, 0x00000000);
    mmio_write(registers.UART0_ICR, 0x7FF);
    // 3 check
	mmio_write(registers.UART0_IBRD, 1);
	mmio_write(registers.UART0_FBRD, 40);
	mmio_write(registers.UART0_LCRH, (1 << 4) | (1 << 5) | (1 << 6));
	mmio_write(registers.UART0_IMSC, (1 << 1) | (1 << 4) | (1 << 5) | (1 << 6) |
	                       (1 << 7) | (1 << 8) | (1 << 9) | (1 << 10));
	mmio_write(registers.UART0_CR, (1 << 0) | (1 << 8) | (1 << 9));
}
