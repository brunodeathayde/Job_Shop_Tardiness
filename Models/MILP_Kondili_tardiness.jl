using JuMP,CPLEX

function MILP_Kondili_tardiness(O,P,d,V,M,N,time_limit)
    model = Model(optimizer_with_attributes(CPLEX.Optimizer,"CPX_PARAM_TILIM" => time_limit, "CPX_PARAM_THREADS" => 1))

    # Number of periods
    H = job_shop_lpt(P,O)

    # Decision variables
    @variable(model, C[j in 1:N] >= 0) 
    @variable(model, x[i in 1:M, j in 1:N, t in 1:H], Bin)  
    @variable(model, T[j in 1:N] >= 0)

    # Objective function
    @objective(model, Min, sum(T[j] for j in 1:N))

    # Constraints
    @constraint(model, [j in 1:N, i in 1:M], sum(x[i,j,t] for t in 1:H) == 1)
    @constraint(model, [j in 1:N, i in 1:M], C[j] >= sum((t + P[j,i] - 1) * x[i,j,t] for t in 1:H))
    @constraint(model, [i in 1:M, t in 1:H], sum(x[i,j,t_] for j in 1:N, t_ in max(1, t - P[j,i] + 1):t) <= 1)
    @constraint(model, [j in 1:N, h in 2:M], sum((t + P[j,O[j,h-1]]) * x[O[j,h-1],j,t] for t in 1:H) <= sum(t * x[O[j,h],j,t] for t in 1:H))
    @constraint(model, [j in 1:N], T[j] >= C[j] - d[j])

    optimize!(model)

    if has_values(model)
        zIP = objective_value(model)
        tzIP = MOI.get(model, MOI.SolveTimeSec())
        LRG = MOI.get(model, MOI.RelativeGap())
    else
        # Nenhuma solução encontrada (nem viável, nem fracionária)
        zIP = -1
        tzIP = time_limit
        LRG = 100
    end

    return (zIP, tzIP, LRG)
end