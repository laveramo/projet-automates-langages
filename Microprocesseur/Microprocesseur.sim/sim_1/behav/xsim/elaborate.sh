#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2023.1 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Fri May 17 10:15:23 CEST 2024
# SW Build 3865809 on Sun May  7 15:04:56 MDT 2023
#
# IP Build 3864474 on Sun May  7 20:36:21 MDT 2023
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# elaborate design
echo "xelab --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot test_BancRegistres_behav xil_defaultlib.test_BancRegistres -log elaborate.log"
xelab --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot test_BancRegistres_behav xil_defaultlib.test_BancRegistres -log elaborate.log

