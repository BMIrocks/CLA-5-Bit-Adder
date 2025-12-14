Below is **clean plain text** you can **directly copy–paste as README.md**.
No markdown tricks, no references, no citations — just paste and go.

---

5-Bit Carry Look-Ahead Adder (CLA) – VLSI Course Project

Author: Het Asit Selarka
Program: Electronics and Communication Engineering
Institute: IIIT Hyderabad
Course: VLSI Design (Monsoon 2025)

---

PROJECT OVERVIEW

This project presents the complete design, implementation, and verification of a synchronous 5-bit Carry Look-Ahead (CLA) adder using 180 nm CMOS technology. The design follows the full VLSI design flow, starting from transistor-level circuit design and timing analysis, progressing through physical layout and post-layout extraction, and finally validating functionality using Verilog HDL and FPGA hardware implementation.

The Carry Look-Ahead Adder architecture significantly reduces carry propagation delay compared to ripple-carry adders by computing carry signals in parallel using propagate and generate logic. The design is fully synchronous, employing True Single-Phase Clock (TSPC) D flip-flops at both the input and output to ensure reliable clocked operation.

---

PROJECT OBJECTIVES

1. Design a 5-bit Carry Look-Ahead Adder with synchronous input and output behavior
2. Implement the adder using static CMOS NAND-based logic
3. Perform detailed pre-layout timing analysis
4. Design physical layouts using MAGIC and extract parasitics
5. Compare pre-layout and post-layout performance
6. Measure setup time, hold time, and clock-to-Q delay of D flip-flops
7. Write a structural Verilog description of the circuit
8. Validate functionality through FPGA implementation

---

ARCHITECTURE DESCRIPTION

The 5-bit CLA adder is divided into the following major blocks:

1. Propagate and Generate (P/G) Block
   For each bit position i:

   * Propagate: pi = ai XOR bi
   * Generate: gi = ai AND bi

2. Carry Look-Ahead Logic
   Carry signals are computed in parallel using expanded Boolean expressions:

   * c1 to c5 are derived directly from propagate and generate signals
   * Multi-input NAND gates are used with De Morgan’s theorem

3. Sum Generation Block

   * si = pi XOR ci-1

4. TSPC D Flip-Flops

   * Input registers capture operands A and B at the rising clock edge
   * Output registers store SUM and COUT at the next rising edge
   * Single-phase clocking ensures reduced skew and fast operation

---

CIRCUIT DESIGN DETAILS

Technology: 180 nm CMOS
Supply Voltage: 1.8 V
Logic Style: Static CMOS
Gate Style: NAND-based universal logic

Transistor Sizing:

* Inverter:

  * NMOS: W/L = 1.8 µm / 0.18 µm
  * PMOS: W/L = 3.6 µm / 0.18 µm
* Multi-input NAND gates:

  * NMOS width scaled proportionally to number of series devices
  * PMOS devices connected in parallel

XOR gates are implemented using four NAND gates to maintain layout regularity and transistor efficiency.

Static CMOS logic was chosen for its full voltage swing, high noise margins, predictable timing behavior, and robustness across process and voltage variations.

---

PRE-LAYOUT TIMING ANALYSIS

D Flip-Flop Timing Parameters:

* Setup Time (tsu): 110 ps
* Hold Time (th): 0 ps
* Clock-to-Q Delay (max): 107.1 ps
* Clock-to-Q Delay (min): 107 ps

Adder Performance:

* Worst-case propagation delay: 0.594 ns
* Minimum clock period: 0.81 ns
* Maximum operating frequency: 1234.56 MHz

---

LAYOUT DESIGN USING MAGIC

Layout Tool: MAGIC
Technology File: SCN6M DEEP.09.tech27

Layouts were created for:

* Inverter
* NAND2, NAND3, NAND4, NAND5
* XOR gate
* Carry logic blocks
* TSPC D Flip-Flop

Floor planning goals:

* Minimize interconnect length
* Maintain regular structure for carry logic
* Separate registers from combinational logic
* Ensure proper VDD and GND routing

Layout Metrics:

* Estimated total area: ~48,955 µm²
* Horizontal pitch (VDD to GND): 179.64 µm
* Vertical pitch: column-wise regular arrangement

---

POST-LAYOUT SIMULATION RESULTS

Parasitic effects included:

* Interconnect capacitances
* Diffusion and gate capacitances
* Metal and poly resistances
* Coupling capacitances

Post-Layout Timing:

* Setup Time: 37.5 ps
* Hold Time: 0 ps
* Clock-to-Q Delay (max): 936 ps
* Worst-case propagation delay: ~0.85 ns

Post-Layout Performance:

* Minimum clock period: 2.03 ns
* Maximum operating frequency: 434.4 MHz

---

PRE-LAYOUT VS POST-LAYOUT COMPARISON

Propagation Delay:

* Pre-layout: 0.59 ns
* Post-layout: 0.85 ns

Minimum Clock Period:

* Pre-layout: 0.81 ns
* Post-layout: 2.03 ns

Maximum Frequency:

* Pre-layout: 1234.6 MHz
* Post-layout: 434.4 MHz

Setup Time:

* Pre-layout: 110 ps
* Post-layout: 37.5 ps

Hold Time:

* Pre-layout: 0 ps
* Post-layout: 0 ps

Performance degradation after layout is mainly due to parasitic capacitances, routing resistance, coupling effects, and realistic interconnect lengths.

---

VERILOG HDL IMPLEMENTATION

* Structural Verilog description
* Gate-level modeling consistent with transistor-level design
* Verified using simulation waveforms
* Functional correctness confirmed for multiple test cases

---

FPGA IMPLEMENTATION

The CLA adder was implemented on FPGA following the prescribed pin assignments and clocking scheme. Hardware validation confirmed correct operation for multiple input combinations, including:

* 11111 + 11111
* 10101 + 01010
* 11000 + 11100

FPGA results matched simulation behavior, validating the correctness of the design.

---

KEY ACHIEVEMENTS

* Complete VLSI design flow from schematic to hardware
* Fully synchronous 5-bit CLA adder with verified timing
* Successful post-layout extraction and analysis
* Demonstrated impact of parasitics on performance
* Verified functionality across transistor, HDL, and FPGA levels

---

TOOLS USED

* NGSPICE: Circuit simulation and timing analysis
* MAGIC: Layout design and parasitic extraction
* Verilog HDL: Structural modeling and simulation
* FPGA toolchain (Vivado): Hardware implementation

---

FUTURE IMPROVEMENTS

* Pipeline carry logic for higher throughput
* Use hybrid CLA and ripple structures for larger bit-widths
* Optimize layout to further reduce parasitics
* Apply advanced transistor sizing techniques
* Explore dynamic logic for critical paths

---

This project demonstrates a complete and realistic CMOS VLSI design workflow, highlighting the importance of timing analysis, layout-aware design, and hardware validation in modern digital circuit design.

---

If you want:

* a **short recruiter-friendly README**
* a **GitHub project description**
* or a **one-page portfolio summary**

tell me and I’ll generate it cleanly.
