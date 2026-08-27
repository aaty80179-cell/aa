# OS Makefile
# Simple build system for the OS project

CC = gcc
CFLAGS = -m32 -ffreestanding -O2 -Wall -Wextra
AS = as
ASFLAGS = --32
LD = ld
LDFLAGS = -m elf_i386

# Directories
BOOT_DIR = os/boot
KERNEL_DIR = os/kernel
DRIVERS_DIR = os/drivers
INCLUDE_DIR = os/include

# Source files
BOOT_SRC = $(BOOT_DIR)/boot.s
KERNEL_SRCS = $(KERNEL_DIR)/*.c $(KERNEL_DIR)/*.s
DRIVER_SRCS = $(DRIVERS_DIR)/*.c

# Object files
BOOT_OBJ = $(BOOT_DIR)/boot.o
KERNEL_OBJS = $(patsubst %.c,%.o,$(wildcard $(KERNEL_DIR)/*.c)) $(patsubst %.s,%.o,$(wildcard $(KERNEL_DIR)/*.s))
DRIVER_OBJS = $(patsubst %.c,%.o,$(wildcard $(DRIVERS_DIR)/*.c))

# Output
KERNEL_BIN = kernel.bin
ISO_FILE = os.iso

all: $(KERNEL_BIN)

$(BOOT_OBJ): $(BOOT_SRC)
	$(AS) $(ASFLAGS) $< -o $@

$(KERNEL_DIR)/%.o: $(KERNEL_DIR)/%.c
	$(CC) $(CFLAGS) -I$(INCLUDE_DIR) -c $< -o $@

$(KERNEL_DIR)/%.o: $(KERNEL_DIR)/%.s
	$(AS) $(ASFLAGS) $< -o $@

$(DRIVERS_DIR)/%.o: $(DRIVERS_DIR)/%.c
	$(CC) $(CFLAGS) -I$(INCLUDE_DIR) -c $< -o $@

$(KERNEL_BIN): $(BOOT_OBJ) $(KERNEL_OBJS) $(DRIVER_OBJS)
	$(LD) $(LDFLAGS) -T os/linker.ld -o $@ $^

clean:
	rm -f $(BOOT_OBJ) $(KERNEL_OBJS) $(DRIVER_OBJS) $(KERNEL_BIN) $(ISO_FILE)

.PHONY: all clean
