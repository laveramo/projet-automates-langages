#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2023.1 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Fri May 31 09:31:49 CEST 2024
# SW Build 3865809 on Sun May  7 15:04:56 MDT 2023
#
# IP Build 3864474 on Sun May  7 20:36:21 MDT 2023
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# simulate design
echo "xsim test_Processeur_behav -key {Behavioral:sim_1:Functional:test_Processeur} -tclbatch test_Processeur.tcl -view /home/vera-morales/PSI/projet-automates-langages/Microprocesseur/simulation.wcfg -log simulate.log"
xsim test_Processeur_behav -key {Behavioral:sim_1:Functional:test_Processeur} -tclbatch test_Processeur.tcl -view /home/vera-morales/PSI/projet-automates-langages/Microprocesseur/simulation.wcfg -log simulate.log

