arm-none-eabi-gcc -mcpu=cortex-m4 -Wl,--script link.ld -nostdlib start.S main.c -o firmware.elf
arm-none-eabi-objcopy -O binary firmware.elf firmware.bin
#st-flash firmware.bin
