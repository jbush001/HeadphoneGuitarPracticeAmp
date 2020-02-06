
MEMORY {
    FLASH (rx) : ORIGIN = 0x8000000, LENGTH = 64k
    SRAM (rwx) : ORIGIN = 0x20000000, LENGTH = 16k
}

SECTIONS {
    .text : {
        . = ALIGN(4);
        KEEP(*(.interrupt_vector))
        *(.text)
        *(.rodata)
    } > FLASH

    _flash_data = .;

    .data : AT (_flash_data) {
        . = ALIGN(4);
        _data_begin = .;
        *(.data)
        _data_end = .;
    } > SRAM

    .bss : {
        . = ALIGN(4);
        _bss_begin = .;
        *(.bss)
        _bss_end = .;
    } > SRAM
}

ENTRY(_reset);
