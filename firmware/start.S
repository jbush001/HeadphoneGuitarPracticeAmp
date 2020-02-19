
            .thumb

            .section .interrupt_vector
            .word 0x20020000    // Stack pointer
            .word _reset
            .word default_handler
            .word default_handler
            .word default_handler
            .word default_handler
            .word default_handler
            .word default_handler
            .word default_handler
            .word default_handler
            .word default_handler
            .word default_handler
            .word default_handler
            .word default_handler
            .word default_handler
            .word default_handler
            .word default_handler
            .word default_handler
            .word default_handler
            .word default_handler

            .text

            .globl _reset
_reset:     // Copy initialized data from flash to SRAM
            ldr r0, =_etext
            ldr r1, =_data
            ldr r2, =_edata
            movs r5, #4
copy_loop:  ldr r3, [r0]
            str r3, [r1]
            add r0, r0, r5
            add r1, r0, r5
            cmp r1, r2
            blo copy_loop

            // Clear BSS
            mov r0, #0
            ldr r1, =_bss
            ldr r2, =_ebss
clear_loop: str r0, [r1]
            add r1, r1, r5
            cmp r1, r2
            blt clear_loop
            b main
done:       b done      // Should never get here

default_handler:
            b default_handler