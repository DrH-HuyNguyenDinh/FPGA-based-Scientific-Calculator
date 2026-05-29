# 🧮 RV32IF Hardware Calculator with Custom CORDIC Accelerator

![RISC-V](https://img.shields.io/badge/Architecture-RISC--V_RV32IF-blue.svg)
![FPGA](https://img.shields.io/badge/Platform-Intel_FPGA_DE10-orange.svg)
![Language](https://img.shields.io/badge/Language-Verilog_%7C_SystemVerilog_%7C_C-green.svg)

> **Undergraduate Graduation Thesis**
> 
> **Author:** Nguyen Dinh Huy  
> **Institution:** Faculty of Electrical and Electronics Engineering, Ho Chi Minh City University of Technology (HCMUT)

## 📖 Overview

This repository contains the hardware and software implementation of a standalone, FPGA-based Hardware Calculator. The system is powered by a custom **RISC-V (RV32IF)** soft-core processor, augmented with a custom **CORDIC hardware accelerator** to compute transcendental mathematical functions efficiently. It interfaces directly with a PS/2 keyboard for user input and an ST7920 LCD (128x64) for both text and graphical output.

## ✨ Key Features

### 1. Hardware Architecture
* **RV32IF Soft-Core CPU:** Fully supports 32-bit integer and IEEE 754 single-precision floating-point operations.
* **Custom CORDIC Coprocessor:** Hardware-level implementation of trigonometric and hyperbolic functions (`sin`, `cos`, `sinh`, `cosh`, `atan`, `atanh`). Invoked via custom `.insn` RISC-V instructions, completely offloading complex calculations from the FPU.
* **Hardware Square Root:** Utilizes the native RV32IF `fsqrt.s` instruction instead of software-based Newton-Raphson iteration for maximum performance.
* **Custom Peripherals:** Custom-designed IP blocks for the PS/2 keyboard controller and the ST7920 LCD driver via memory-mapped I/O (MMIO).

### 2. Firmware (Bare-metal C)
* **Advanced Math Parser:** A robust recursive-descent parser supporting parentheses, operator precedence, and floating-point evaluation for functions including `sin`, `cos`, `tan`, `asin`, `acos`, `atan`, `sinh`, `cosh`, `exp`, `ln`, `log10`, `pow`, and `sqrt`.
* **Text Mode (Calculator Interface):** 
  * Features a non-blocking software inline cursor (`|`).
  * Smooth editing capabilities (left/right navigation, backspace, delete).
  * Advanced PS/2 debouncing and multi-keystroke ghosting prevention algorithms.
* **Graphic Mode (Function Plotter):**
  * Parses commands like `graph(x^2)` or `graph(sin(x))` and plots them dynamically.
  * Direct GDRAM manipulation for the 128x64 LCD.
  * Employs an optimized Integer Parser for rendering pixels mapped accurately to a dynamic coordinate system (X: -64 to +63, Y: -32 to +31) to drastically improve drawing latency.

## 🛠️ Hardware Requirements

* **Development Board:** Terasic DE10 (Intel Cyclone V FPGA)
* **System Clock:** 20 MHz
* **Peripherals:** Standard PS/2 Keyboard, 128x64 ST7920 LCD Module (SPI/Parallel interface)

## 🚀 How to Build and Run

### 1. Hardware Synthesis
1. Navigate to the `hardware/` directory.
2. Open the project in **Intel Quartus Prime**.
3. Compile the design and program the `.sof` file onto the DE10 FPGA board.

### 2. Firmware Compilation
1. Ensure the **RISC-V GNU Compiler Toolchain** (`riscv32-unknown-elf-gcc`) is installed and added to your system's PATH.
2. Navigate to the `firmware/` directory:
```bash
   cd firmware
   make

This will generate the necessary binary/hex files. Load the compiled binary into the FPGA's instruction memory (via JTAG or by updating the .mif memory initialization file in Quartus and recompiling).

## 📸 Demonstrations
(Replace the links below with your actual project images or GIFs)

### Calculator Mode
Standard text mode evaluating floating-point trigonometric expressions.

### Function Plotter (Graphic Mode)
Real-time plotting of mathematical functions on the ST7920 LCD.

This project was developed as a Graduation Thesis in Circuit and Hardware System Area
