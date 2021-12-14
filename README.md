# ARM Processor Implementation

- A single-cycle microarchitecture for a subset of the ARMv7 instruction set architecture in Digital
- Supports all instructions that appear in unit tests 00-23
- The implementation includes:
1. The 32-bit Program Counter (PC) with enable (EN) and clear (CLR) inputs.
2. Machine code programs stored in a ROM components.
3. The Register File that supports reading 3 registers in a single clock cycle: RD0, RD1, and RD2.
4. The Arithmetic Logic Unit (ALU) that performs data processing tasks.
5. The Sign Extension Unit (Extender) that performs 8-bit zero extension, 12-bit zero extension, and 24 bit sign extension.
6. The Shift Unit (Shifter) that supports shifts in mov and SDT instructions.
7. The Data Memory used for stack memory by our test programs. 
8. The Control Unit that decodes machine code instructions and supports conditional branch execution. 
9. The Data Path that connects data between the various sub-circuits.
10. The Control Path that connects the Control unit to various sub-circuits and multiplexers

## Usage
*Prerequisite is having Java installed on the host OS. The latest distribution of Digital can be downloaded here  [Digital download page](https://github.com/hneemann/Digital/releases/tag/v0.28)*

*[More instructions on Digital](https://github.com/hneemann/Digital)*

Driver program is in `project06.dig`.
