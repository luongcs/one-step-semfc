
# One-Step SEMFC

## Replacing Iterative Constrained Likelihood in Hybrid Structural Models with a Spectrally Initialized One-Step Estimator

Accepted at NewInML Workshop at the 40th Conference on
Neural Information Processing Systems
(NeurIPS 2026), Paris, France, 2026.

This repository provides the implementation and reproducibility code associated with the paper.

The proposed method combines the SVD-SEM spectral initializer with a single constrained Fisher-scoring correction to obtain an estimator that is asymptotically equivalent to restricted maximum likelihood, without requiring fully iterative likelihood optimization.

The repository contains the scripts used to reproduce the numerical experiments, tables, and figures presented in the paper.

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

