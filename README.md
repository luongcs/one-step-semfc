# Reproducibility Code

This repository contains the code used to reproduce the numerical
experiments, tables, and figures of the accompanying anonymous submission.

## Structure

The package implementation and estimation routines are located in `R/`.

The Monte Carlo experiments are implemented in:

- `inst/os_experiments/experiment_one_step.R`: scaling with sample size;
- `inst/os_experiments/experiment_one_step_blocks.R`: scaling with the number of blocks;
- `inst/os_experiments/experiment_one_step_indicators.R`: scaling with the number of
  indicators per block.

The corresponding scripts used to produce the tables and figures are:

- `inst/os_experiments/print_result_n.R`;
- `inst/os_experiments/print_result_J.R`;
- `inst/os_experiments/print_result_q.R`.

The script `main.R` provides a single entry point for reproducing all
reported results.

## Software requirements

The experiments were run using R 4.3.0.

The main R package dependencies are listed in `DESCRIPTION`.

