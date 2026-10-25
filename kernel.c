
// Sample code as a start to kernel
void kernel_main() {
    // VGA text mode buffer starts at 0xB8000
    char *video_memory = (char *) 0xB8000;
    
    // Print "OK" to the screen (Character + Color Attribute byte)
    video_memory[0] = 'O';
    video_memory[1] = 0x0f; // White text on black background
    video_memory[2] = 'K';
    video_memory[3] = 0x0f;

    // Hang forever so the kernel doesn't crash/reboot
    while (1) {
        __asm__("hlt"); // Halt CPU instruction to save resources
    }
}