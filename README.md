# Layered SystemVerilog Testbench for `spii2c`

This project demonstrates a **layered testbench architecture** in SystemVerilog for the `spii2c` design module. It follows UVM-lite principles using separate components like transaction, generator, driver, monitor, scoreboard, and environment.

## Project Structure
* spii2c.sv # Design Under Test (DUT)
* transaction.sv # Transaction class (data object)
* generator.sv # Generates random transactions
* driver.sv # Drives transactions to DUT
* monitor.sv # Observes DUT outputs
* scoreboard.sv # Compares expected vs actual results
* environment.sv # Connects all components
* tb.sv # Top-level testbench module
* run_tb.sv # Master include file to run the simulation

## How to Run

Use any SystemVerilog simulator (ModelSim, VCS, XSIM, Verilator) to run the testbench.
