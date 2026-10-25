CC = x86_64-elf-gcc
AS = nasm

CFLAGS = -ffreestanding -O2 -Wall -Wextra
LDFLAGS = -T linker.ld -nostdlib

all: mykernel.iso

kernel.bin: boot.o kernel.o linker.ld
	$(CC) $(LDFLAGS) -o kernel.bin boot.o kernel.o

boot.o: boot.s
	$(AS) -f elf64 boot.s -o boot.o

kernel.o: kernel.c
	$(CC) $(CFLAGS) -c kernel.c -o kernel.o

mykernel.iso: kernel.bin
	mkdir -p iso/boot/grub
	cp kernel.bin iso/boot/grub/kernel.bin
	cp grub.cfg iso/boot/grub/grub.cfg
	grub-mkrescue -o mykernel.iso iso

clean:
	rm -rf *.o kernel.bin mykernel.iso iso