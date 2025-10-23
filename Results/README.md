
**Examples:**
- `PFVT_Manne_CPLEX.csv`
- `Demirkol_Liao_Gurobi.csv`
- `Lawrence_Liao_CPLEX.csv`

## 📐 CSV Structure

Each file contains the following columns:

| Column | Description |
|--------|-------------|
| `zIP`  | Best integer solution found by the solver. A value of `-1` indicates that no feasible integer solution was found within the time limit. |
| `t`    | Computational time in seconds. |
| `gap`  | Linear relaxation gap (%) between the best integer solution and the lower bound. |

## ⚠️ Interpretation Notes

- A `zIP` value of `-1` means the solver failed to find a feasible solution in the allotted time.
- A high `gap` value may indicate poor relaxation or difficulty in convergence.
- Lower `t` and `gap` values generally reflect better solver performance and model efficiency.

## 🧮 Solvers Used

- **CPLEX**: IBM CPLEX Optimizer
- **Gurobi**: Gurobi Optimizer

Ensure that both solvers are properly installed and licensed before replicating the experiments.

## 📚 Related Models

The results correspond to MILP models implemented in Julia using JuMP. See the main repository for source code and model descriptions.

---
