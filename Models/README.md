# 🔧 MILP Models for Job Shop Scheduling with Tardiness Minimization

This repository contains a collection of **Mixed Integer Linear Programming (MILP)** models implemented in **Julia** for solving job shop scheduling problems with a focus on **tardiness minimization**. The models are based on classical formulations from the literature and are designed to be run using the JuMP modeling language with solvers such as **CPLEX** and **Gurobi**.

## 📁 Source Files

The following Julia scripts are included:

- `main.jl` — Main execution script that coordinates model selection and instance loading.
- `read_instance.jl` — Reads and parses job shop problem instances.
- `job_shop_lpt.jl` — Implements a heuristic based on the Longest Processing Time (LPT) rule.
- `MILP_Kondili_tardiness.jl` — MILP model based on Kondili et al.'s formulation.
- `MILP_Liao_tardiness.jl` — MILP model based on Liao et al.'s approach.
- `MILP_Manne_tardiness.jl` — MILP model based on Manne's classical formulation.
- `MILP_Wagner_tardiness.jl` — MILP model based on Wagner's formulation.

## 🚀 Getting Started

### Prerequisites

To run these models, you need to have Julia installed. You can download it from [https://julialang.org/downloads](https://julialang.org/downloads).

### Package Installation

Open Julia and install the required packages:

```julia
using Pkg
Pkg.add("JuMP")
Pkg.add("CPLEX")   # If you have access to IBM CPLEX
Pkg.add("Gurobi")  # If you have access to Gurobi
