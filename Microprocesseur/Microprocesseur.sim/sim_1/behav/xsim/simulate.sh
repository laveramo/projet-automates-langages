#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2023.1 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Fri May 17 09:06:28 CEST 2024
# SW Build 3865809 on Sun May  7 15:04:56 MDT 2023
#
# IP Build 3864474 on Sun May  7 20:36:21 MDT 2023
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# simulate design
echo "xsim test_ALU_behav -key {Behavioral:sim_1:Functional:test_ALU} -tclbatch test_ALU.tcl -log simulate.log"
xsim test_ALU_behav -key {Behavioral:sim_1:Functional:test_ALU} -tclbatch test_ALU.tcl -log simulate.log

