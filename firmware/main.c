
//
// Blink the LED attached to PB11
//

volatile unsigned int * const REGB_BASE = ((unsigned int*) 0x48000400);

#define MODE_REG 0
#define OD_REG 5


void main() {
    unsigned int counter = 0;

    REGB_BASE[MODE_REG] = 1 << 22;  // Make this port an output, everything else an input

    while (1) {
        REGB_BASE[OD_REG] = (((counter >> 25) & 1) << 11);
        counter++;
    }
}
