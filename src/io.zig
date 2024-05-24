const registers = @import("registers.zig");

fn write32(register: u32, data: u32) void {
    const ptr: *volatile u32 = @ptrFromInt(registers.MMIO_BASE + register);
    ptr.* = data;
}


fn read32(register: u32) u32 {
    const ptr: *volatile u32 = @ptrFromInt(registers.MMIO_BASE + register);
    return ptr.*;
}


fn wait_for_ready(flag: u32) void {
    while (read32(registers.FR) & flag > 0) {}
}

pub fn putc(c: u8) void {
    wait_for_ready((1 << 5));
    write32(registers.DR, c);
}

pub fn readc() u8 {
    wait_for_ready((1 << 4));
    return @intCast(read32(registers.DR));
}

pub fn write(s: [] const u8) void {
    for (s) |c| {
        putc(c);
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

pub fn get_exception_level() i32 {
    var el: i32 = undefined;
	asm volatile(
	    "mrs %[el], CurrentEL\nlsr %[el], %[el], #2\n"
        : [el]"=r" (el)
        :
        : "cc"
	);
	return el;
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

    write32(registers.CR, 0x00000000);
    write32(registers.GPPUD, 0x00000000);
    delay(150);
    write32(registers.GPPUDCLK0, (1 << 14) | (1 << 15));
    delay(150);
    write32(registers.GPPUDCLK0, 0x00000000);
    write32(registers.ICR, 0x7FF);


    {

        while (( read32(registers.MBOX_STATUS) & 0x80000000) != 0) { }

        const mbox_ptr : * align(16) volatile u32 = @ptrCast(&mbox);
        const r: u32 = @intCast((@intFromPtr(mbox_ptr) & ~@as(u32, 0xF)) | 8);
        write32(registers.MBOX_WRITE, r);

        // while (
        //     (read32(registers.MBOX_STATUS) & 0x40000000) != 0 or
        //     read32(registers.MBOX_READ) != r
        // ) { }
    }

	write32(registers.IBRD, 1);
	write32(registers.FBRD, 40);
	write32(registers.LCRH, (1 << 4) | (1 << 5) | (1 << 6));
	write32(registers.IMSC, (1 << 1) | (1 << 4) | (1 << 5) | (1 << 6) |
	                       (1 << 7) | (1 << 8) | (1 << 9) | (1 << 10));
	write32(registers.CR, (1 << 0) | (1 << 8) | (1 << 9));
}
