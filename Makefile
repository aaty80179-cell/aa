# Makefile for OS Project

CC = gcc
CFLAGS = -m32 -ffreestanding -O2 -Wall -Wextra
AS = as
ASFLAGS = --32
LD = ld
LDFLAGS = -m elf_i386

BOOT_DIR = boot
KERNEL_DIR = kernel
DRIVERS_DIR = drivers
INCLUDE_DIR = include

# Source files
BOOT_SRC = $(BOOT_DIR)/boot.s
KERNEL_SRCS = $(wildcard $(KERNEL_DIR)/*.c) $(wildcard $(KERNEL_DIR)/**/*.c)
KERNEL_ASMS = $(wildcard $(KERNEL_DIR)/*.s) $(wildcard $(KERNEL_DIR)/**/*.s)
DRIVER_SRCS = $(wildcard $(DRIVERS_DIR)/*.c)

# Object files
BOOT_OBJ = $(BOOT_DIR)/boot.o
KERNEL_OBJS = $(KERNEL_SRCS:.c=.o) $(KERNEL_ASMS:.s=.o)
DRIVER_OBJS = $(DRIVER_SRCS:.c=.o)

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
	$(LD) $(LDFLAGS) -T linker.ld -o $@ $^

clean:
	find . -name "*.o" -delete
	rm -f $(KERNEL_BIN) $(ISO_FILE)

rebuild: clean all

.PHONY: all clean rebuild
