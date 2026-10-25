global start
extern kernel_main

section .multiboot
header_start:
    dd 0xe85250d6                ; Multiboot2 magic number
    dd 0                         ; Architecture 0 (protected mode i386)
    dd header_end - header_start ; Header length
    dd -(0xe85250d6 + 0 + (header_end - header_start)) ; Checksum

    ; Required end tag
    dw 0
    dw 0
    dd 8
header_end:

section .bss
align 16
stack_bottom:
    resb 16384                   ; 16 KB stack
stack_top:

section .text
bits 32
start:
    mov esp, stack_top           ; Set up the stack pointer

    ; Call the C kernel entry point
    call kernel_main

    ; Hang if the kernel ever returns
    cli
.hang:
    hlt
    jmp .hang