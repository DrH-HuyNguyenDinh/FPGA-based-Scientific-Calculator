# <img width="39.6065574" height="40" alt="image" src="https://github.com/user-attachments/assets/1c6d938b-55cf-4f6e-b5e5-4482c5753911" /> RV32IF Hardware Calculator with Custom CORDIC Accelerator <img src="https://flagcdn.com/w40/vn.png" alt="Vietnam Flag" />

![RISC-V](https://img.shields.io/badge/Architecture-RISC--V_RV32IF-blue.svg)
![FPGA](https://img.shields.io/badge/Platform-Intel_FPGA_DE10-orange.svg)
![Language](https://img.shields.io/badge/Language-Verilog_%7C_SystemVerilog_%7C_C-green.svg)

> **Undergraduate Graduation Project**
> 
> **Author:** Nguyen Dinh Huy  
> **Institution:** Faculty of Electrical and Electronics Engineering, Ho Chi Minh City University of Technology (HCMUT)

## 📖 Overview

This repository contains the hardware and software implementation of a standalone, FPGA-based Hardware Calculator. The system is powered by a custom **RISC-V (RV32IF)** soft-core processor, augmented with a custom **CORDIC** to compute transcendental mathematical functions efficiently. It interfaces directly with a PS/2 keyboard for user input and an ST7920 LCD (128x64) for both text and graphical output.

## ✨ Key Features

### 1. Hardware Architecture
* **RV32IF Soft-Core CPU:** Fully supports 32-bit integer and IEEE 754 single-precision floating-point operations.
* **Custom CORDIC Coprocessor:** Hardware-level implementation of trigonometric and hyperbolic functions (`sin`, `cos`, `sinh`, `cosh`, `atanh`). Invoked via custom `.insn` RISC-V instructions, completely offloading complex calculations from the FPU.
* **Hardware Square Root:** Utilizes the native RV32IF `fsqrt.s` instruction instead of software-based Newton-Raphson iteration for maximum performance.
* **Custom Peripherals:** Custom-designed IP blocks for the PS/2 keyboard controller and the ST7920 LCD driver via memory-mapped I/O (MMIO).

### 2. Firmware (Bare-metal C)
* **Advanced Math Parser:** A robust recursive-descent parser supporting parentheses, operator precedence, and floating-point evaluation for functions including `sin`, `cos`, `tan`, `asin`, `acos`, `atan`, `sinh`, `cosh`, `exp`, `ln`, `log10`, `pow`, and `sqrt`.
* **Text Mode (Calculator Interface):** 
  * Features a non-blocking software inline cursor (`|`).
  * Smooth editing capabilities (left/right navigation, backspace, delete).
  * Advanced PS/2 debouncing and multi-keystroke ghosting prevention algorithms.
* **Graphic Mode (Function Plotter):**
  * Parses commands like `graph(x*x)` or `graph(98/x)` and plots them dynamically.
  * Direct GDRAM manipulation for the 128x64 LCD.
  * Employs an optimized Integer Parser for rendering pixels mapped accurately to a dynamic coordinate system (X: -64 to +63, Y: -32 to +31) to drastically improve drawing latency.

## 🧑‍💻 Block Diagram
<img width="16384" height="11813" alt="image" src="https://github.com/user-attachments/assets/3baad6a8-d2d1-48c5-8331-c4773a356cb1" />

## 🛠️ Hardware Requirements

* **Development Board:** Terasic DE10 (Intel Cyclone V FPGA)
* **System Clock:** 20 MHz
* **Peripherals:** Standard PS/2 Keyboard, 128x64 ST7920 LCD Module (Parallel interface)

## 🚀 How to Build and Run

### 1. Hardware Synthesis
1. Navigate to the `hardware/` directory.
2. Open the project in **Intel Quartus Prime**.
3. Compile the design and program the `.sof` file onto the DE10 FPGA board.

### 2. Firmware Compilation
1. Ensure the **RISC-V GNU Compiler Toolchain** (`riscv32-unknown-elf-gcc`) is installed and added to your system's PATH.
2. Navigate to the `firmware/` directory:
```
   make clean
   make all
```
This will generate the necessary binary/hex files. Load the compiled binary into the FPGA's instruction memory (by updating the .txt memory initialization file in Quartus and recompiling).

## 📸 Demonstrations
<img width="2560" height="1920" alt="z7787414873664_e0a4e6161f9435360f0ae7c8c9a69898" src="https://github.com/user-attachments/assets/a21bdf01-4de6-4e8e-a31e-89c5d08a0090" />
<img width="2560" height="1920" alt="z7787414835259_7c19f1c152ea9ab21905167058e7b7f6" src="https://github.com/user-attachments/assets/22c9b889-35d0-49a6-9ce6-529e03ea5b01" />
<img width="2560" height="1920" alt="z7787414823350_d6c951cc0fc2a15ae465e8340faf741a" src="https://github.com/user-attachments/assets/5d6db028-e8ed-4c2f-8c5a-f692c00d733d" />

https://github.com/user-attachments/assets/2daf2459-b829-4780-bf0f-693e8b35c1d0

https://github.com/user-attachments/assets/476a017d-5a24-469e-9c29-c8f84eb7457c

### Calculator Mode
Standard text mode evaluating floating-point trigonometric expressions.

### Function Plotter (Graphic Mode)
Real-time plotting of mathematical functions on the ST7920 LCD.

This project was developed as a Graduation Project in Circuit and Hardware System Area
