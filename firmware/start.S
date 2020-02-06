
            .thumb

            .section .interrupt_vector
            .word 0x20004000    // Stack pointer
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


            .globl _reset
_reset:     // Copy initialized data from flash to SRAM
            ldr r0, =_flash_data
            ldr r1, =_data_begin
            ldr r2, =_data_end
            movs r5, #4
copy_loop:  ldr r3, [r0]
            str r3, [r1]
            add r0, r0, r5
            add r1, r0, r5
            cmp r1, r2
            blt copy_loop

            // Clear BSS
            mov r0, #0
            ldr r1, =_bss_begin
            ldr r2, =_bss_end
clear_loop: str r0, [r1]
            add r1, r1, r5
            cmp r1, r2
            blt clear_loop
            b main
done:       b done      // Should never get here

default_handler:
            b default_handler