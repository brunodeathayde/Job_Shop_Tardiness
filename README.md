# ⚙️ Job Shop Scheduling with Total Tardiness Minimization

This repository contains source code, benchmark instances, and computational results for solving job shop scheduling problems using **Mixed Integer Linear Programming (MILP)** models. The focus is on minimizing **tardiness** across various classical formulations and datasets.

## 📁 Repository Structure

### `/Models`
Contains Julia source code for MILP formulations implemented using the [JuMP.jl](https://jump.dev/) modeling language. Models are based on well-known approaches from the literature, including:

- **Manne**
- **Liao**
- **Kondili**
- **Wagner**

Each model is designed to be compatible with solvers such as **CPLEX** and **Gurobi**.

> 📦 Required Julia packages:
> ```julia
> using Pkg
> Pkg.add("JuMP")
> Pkg.add("CPLEX")   # If available
> Pkg.add("Gurobi")  # If available
> ```

### `/Instances`
Includes benchmark datasets used to evaluate the MILP models. These instances represent job shop scheduling scenarios with varying numbers of jobs, machines, and processing times.

### `/Results`
Contains CSV files with computational results for each model and solver combination. Each file includes:

- `zIP`: Best integer solution found. A value of `-1` indicates no feasible solution was found within the time limit.
- `t`: Computational time in seconds.
- `gap`: Linear relaxation gap (%).

> Example files:
> - `PFVT_Manne_CPLEX.csv`
> - `Demirkol_Liao_Gurobi.csv`
> - `Lawrence_Liao_CPLEX.csv`
