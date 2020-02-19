
MEMORY {
    FLASH (rx) : ORIGIN = 0x8000000, LENGTH = 512k
    SRAM (rwx) : ORIGIN = 0x20000000, LENGTH = 128k
}

SECTIONS {
    .text : ALIGN(4) {
        KEEP(*(.interrupt_vector))
        *(.text .text.*)
        *(.rodata .rodata.*)
        _etext = .;
    } > FLASH

    /* https://sourceware.org/binutils/docs/ld/Output-Section-LMA.html#Output-Section-LMA */
    .data : AT (ALIGN(ADDR(.text) + SIZEOF(.text), 4)) ALIGN(4) {
        _data = .;
        *(.data .data.*)
        _edata = .;
    } > SRAM

    .bss : ALIGN(4) {
        _bss = .;
        *(.bss .bss.*)
        _ebss = .;
    } > SRAM
}

ENTRY(_reset);
