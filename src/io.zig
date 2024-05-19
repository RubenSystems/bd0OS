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

pub fn hr() void {
    for (0..10) |_| {
        putc('=');
    }
}



fn delay(count: i32) void {
    var remaining: i32 = count;
	asm volatile(
	   "1: subs %[remaining], %[remaining], #1\nbne 1b\n"
        : [remaining]"+r" (remaining)
        :
        : "cc"
	);
}


var mbox align(16) = [9] u32 {
    9*4,
    0,
    0x38002,
    12,
    8,
    2,
    3000000,
    0,
    0
};

pub fn init() void {

    mmio_write(registers.UART0_CR, 0x00000000);
    mmio_write(registers.GPPUD, 0x00000000);
    delay(150);
    mmio_write(registers.GPPUDCLK0, (1 << 14) | (1 << 15));
    delay(150);
    mmio_write(registers.GPPUDCLK0, 0x00000000);
    mmio_write(registers.UART0_ICR, 0x7FF);


    {

        while (( mmio_read(registers.MBOX_STATUS) & 0x80000000) != 0) { }

        const mbox_ptr : * align(16) volatile u32 = @ptrCast(&mbox);
        const r: u32 = @intCast((@intFromPtr(mbox_ptr) & ~@as(u32, 0xF)) | 8);
        mmio_write(registers.MBOX_WRITE, r);

        // while (
        //     (mmio_read(registers.MBOX_STATUS) & 0x40000000) != 0 or
        //     mmio_read(registers.MBOX_READ) != r
        // ) { }
    }



	mmio_write(registers.UART0_IBRD, 1);
	mmio_write(registers.UART0_FBRD, 40);
	mmio_write(registers.UART0_LCRH, (1 << 4) | (1 << 5) | (1 << 6));
	mmio_write(registers.UART0_IMSC, (1 << 1) | (1 << 4) | (1 << 5) | (1 << 6) |
	                       (1 << 7) | (1 << 8) | (1 << 9) | (1 << 10));
	mmio_write(registers.UART0_CR, (1 << 0) | (1 << 8) | (1 << 9));
	delay(1000);
}
