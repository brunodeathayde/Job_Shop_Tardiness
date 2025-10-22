# 📊 Job Shop Scheduling Problem – Test Instances for Total Tardiness Minimization

This repository contains benchmark test instances for the **Job Shop Scheduling Problem (JSSP)** with the objective of **minimizing total tardiness**. These datasets are widely used in academic research and algorithm evaluation.

## 📁 Folder Structure

Each folder contains instances from a different set of authors or benchmark collections:

- **Demirkol, Mehta, and Uzsoy**  
  Classic instances designed to test scheduling heuristics under varying machine and job configurations.

- **Lawrence**  
  A well-known benchmark set often used for evaluating exact and heuristic methods in JSSP.

- **Prata, Fernandez-Viagas, and Talens**  
  Recent instances tailored for tardiness-based objectives, including due dates and tight scheduling constraints.

- **Storer, Wu and Vaccari**  
  Instances with diverse job routing and processing time characteristics, useful for testing robustness.

- **Taillard**  
  Large-scale and complex instances that challenge the scalability of scheduling algorithms.

## 🧠 Problem Description

In the **Job Shop Scheduling Problem with Total Tardiness Minimization**, the goal is to schedule a set of jobs—each consisting of a sequence of operations on specific machines—such that the **sum of tardiness across all jobs is minimized**. Tardiness is defined as:



\[
T_j = \max(0, C_j - d_j)
\]



Where:
- \( T_j \) is the tardiness of job \( j \)
- \( C_j \) is the completion time of job \( j \)
- \( d_j \) is the due date of job \( j \)

## 📚 Usage

These instances can be used to:
- Benchmark scheduling algorithms
- Train machine learning models for scheduling
- Compare heuristic and metaheuristic performance
- Reproduce results from academic papers

## 📜 Citation

If you use these instances in your research, please cite the original authors of each dataset. Refer to the respective folder for citation details.

## 🤝 Contributions

Feel free to contribute additional instances, parsers, or solvers. Open a pull request or submit an issue to get started.
