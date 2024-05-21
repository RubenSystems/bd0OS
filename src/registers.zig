
pub const MMIO_BASE: u32 = 0x3F000000;
pub const GPIO_BASE: u32 = 0x200000;
pub const UART0_DR: u32 = UART0_BASE + 0x00;
pub const UART0_FR: u32 = UART0_BASE + 0x18;

// The offsets for each register.
// Controls actuation of pull up/down to ALL GPIO pins.
pub const GPPUD = GPIO_BASE + 0x94;
// Controls actuation of pull up/down for specific GPIO pin.
pub const GPPUDCLK0 = GPIO_BASE + 0x98;
// The base address for UART.
// for raspi4 0xFE201000, raspi2 & 3 0x3F201000, and 0x20201000 for raspi1
pub const UART0_BASE = GPIO_BASE + 0x1000;
// The offsets for each register for the UART.
pub const UART0_RSRECR = UART0_BASE + 0x04;
pub const UART0_ILPR   = UART0_BASE + 0x20;
pub const UART0_IBRD   = UART0_BASE + 0x24;
pub const UART0_FBRD   = UART0_BASE + 0x28;
pub const UART0_LCRH   = UART0_BASE + 0x2C;
pub const UART0_CR     = UART0_BASE + 0x30;
pub const UART0_IFLS   = UART0_BASE + 0x34;
pub const UART0_IMSC   = UART0_BASE + 0x38;
pub const UART0_RIS    = UART0_BASE + 0x3C;
pub const UART0_MIS    = UART0_BASE + 0x40;
pub const UART0_ICR    = UART0_BASE + 0x44;
pub const UART0_DMACR  = UART0_BASE + 0x48;
pub const UART0_ITCR   = UART0_BASE + 0x80;
pub const UART0_ITIP   = UART0_BASE + 0x84;
pub const UART0_ITOP   = UART0_BASE + 0x88;
pub const UART0_TDR    = UART0_BASE + 0x8C;
// The offsets for Mailbox registers
pub const MBOX_BASE    = 0xB880;
pub const MBOX_READ    = MBOX_BASE + 0x00;
pub const MBOX_STATUS  = MBOX_BASE + 0x18;
pub const MBOX_WRITE   = MBOX_BASE + 0x20;
