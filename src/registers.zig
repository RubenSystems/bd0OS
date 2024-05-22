
// Base registers
pub const MMIO_BASE: u32 = 0x3F000000;
pub const GPIO_BASE: u32 = 0x200000;
pub const UART0_BASE = GPIO_BASE + 0x1000;
pub const MBOX_BASE: u32 = 0xB880;

pub const GPPUD = GPIO_BASE + 0x94;
pub const GPPUDCLK0 = GPIO_BASE + 0x98;


// NOTE:
//
// These are not random numbers
// the definiions are here:
//
//
// https://cs140e.sergio.bz/docs/BCM2837-ARM-Peripherals.pdf
// Page 178

pub const DR = UART0_BASE + 0x00;
pub const FR = UART0_BASE + 0x18;
pub const RSRECR = UART0_BASE + 0x04;
pub const ILPR = UART0_BASE + 0x20;
pub const IBRD = UART0_BASE + 0x24;
pub const FBRD = UART0_BASE + 0x28;
pub const LCRH = UART0_BASE + 0x2C;
pub const CR = UART0_BASE + 0x30;
pub const IFLS = UART0_BASE + 0x34;
pub const IMSC = UART0_BASE + 0x38;
pub const RIS = UART0_BASE + 0x3C;
pub const MIS = UART0_BASE + 0x40;
pub const ICR = UART0_BASE + 0x44;
pub const DMACR = UART0_BASE + 0x48;
pub const ITCR = UART0_BASE + 0x80;
pub const ITIP = UART0_BASE + 0x84;
pub const ITOP = UART0_BASE + 0x88;
pub const TDR = UART0_BASE + 0x8C;


// Mailbox registers
pub const MBOX_READ = MBOX_BASE + 0x00;
pub const MBOX_STATUS = MBOX_BASE + 0x18;
pub const MBOX_WRITE = MBOX_BASE + 0x20;
