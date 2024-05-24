TARGET = bin/bd0.elf
KERNEL_TARGET = libmain.a
BOOTLOADER_TARGET = bin/boot.o

BOOTLOADER_SOURCE = boot.S

all: build

run: build
	# qemu-system-aarch64 -M raspi3b -serial stdio -kernel $(TARGET)
	qemu-system-aarch64 -M raspi3b -kernel $(TARGET) -nographic

build:
	${AARCH64_AS} -c $(BOOTLOADER_SOURCE) -o $(BOOTLOADER_TARGET)
	zig build-lib src/main.zig -target aarch64-freestanding -fcompiler-rt
	${AARCH64_CC} -T linker.ld -o $(TARGET) -ffreestanding -O2 -nostdlib $(BOOTLOADER_TARGET) $(KERNEL_TARGET) -lgcc

clean:
	rm $(TARGET) $(BOOTLOADER_TARGET) $(KERNEL_TARGET)
