
//
// Blink the LED attached to PB11
//

#define GPIO_REGB_BASE ((volatile unsigned int*) 0x48000400)
#define RCC_BASE ((volatile unsigned int*) 0X40021000)
#define GPIO_MODE 0
#define GPIO_OD 5
#define RCC_AHB2EN (0x4c / 4)

void main() {
    unsigned int counter = 0;

    // Enable clocks for GPIO blocks A, B, and C
    RCC_BASE[RCC_AHB2EN] = 0x7;

    // Make PB11 an output, everything else an input
    GPIO_REGB_BASE[GPIO_MODE] = 1 << 22;

    while (1) {
        GPIO_REGB_BASE[GPIO_OD] = (((counter >> 25) & 1) << 11);
        counter++;
    }
}
