Setting up software development environment:

* <https://www.amazon.com/Aideepen-ST-Link-Programming-Emulator-Downloader/dp/B01J7N3RE6>
* <https://www.amazon.com/DSD-TECH-SH-U09C2-Debugging-Programming/dp/B07TXVRQ7V>

## Macos

Install ARM toolchain:

    brew tap ArmMbed/homebrew-formulae
    brew install arm-none-eabi-gcc

## Linux

    sudo apt-get install gcc-arm-none-eabi binutils-arm-none-eabi

This requires at least version 1.6.1 of the st-link tools for STM32G4 support. This version
is not in Homebrew (at least), so they need to be built manually following instructions here:
<https://github.com/stlink-org/stlink/blob/develop/doc/compiling.md#macOS>
