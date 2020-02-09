Setting up software development environment:

* <https://www.amazon.com/Aideepen-ST-Link-Programming-Emulator-Downloader/dp/B01J7N3RE6>
* <https://www.amazon.com/DSD-TECH-SH-U09C2-Debugging-Programming/dp/B07TXVRQ7V>

## Macos

Install ARM toolchain and stlink tools:

    brew tap ArmMbed/homebrew-formulae
    brew install arm-none-eabi-gcc stlink

## Linux

    sudo apt-get install stlink-tools gcc-arm-none-eabi binutils-arm-none-eabi
