STLINK_PATH=~/src/3rdParty/stlink/build/Release/bin/

arm-none-eabi-gcc -O3 -mcpu=cortex-m4 -Wl,--script link.ld -nostdlib start.S main.c -o firmware.elf
arm-none-eabi-objcopy -O binary firmware.elf firmware.bin
$STLINK_PATH/st-flash write firmware.bin 0x8000000
