.section ".text.boot"
.globl _start
    .org 0x80000

// Entry point for the kernel. Registers:
// x0 -> 32 bit pointer to DTB in memory (primary core only) / 0 (secondary cores)
// x1 -> 0
// x2 -> 0
// x3 -> 0
// x4 -> 32 bit kernel entry point, _start location
_start:

    //get processor id
    mrs	x0, mpidr_el1

    // make it 8 bit
	and	x0, x0,#0xFF

	// branch to config function if on processor 0
	cbz	x0, config_proc_0

config_proc_0:
    // for register values, look at p2654 of AArch64-Reference-Manual.
    ldr    x0, =((3 << 28) | (3 << 22) | (1 << 20) | (1 << 11) | (0 << 25) | (0 << 12) | (0 << 2) | (0 << 0))
    msr    sctlr_el1, x0

    ldr    x1, =(1 << 31)
    msr    hcr_el2, x1

    ldr    x2, =((3 << 4) | (1 << 10) | (1 << 0))
    msr    scr_el3, x2

    ldr    x3, =((7 << 6) | (5 << 0))
    msr    spsr_el3, x3

    adr    x4, boot
    msr    elr_el3, x4

    eret

boot:
    // setup stack pointer
    ldr     x5, =_start
    mov     sp, x5

    // clear bss
    ldr     x5, =__bss_start
    ldr     w6, =__bss_size
1:  cbz     w6, 2f
    str     xzr, [x5], #8
    sub     w6, w6, #1
    cbnz    w6, 1b

    // jump to main kernel
2:  bl      kernel_main
