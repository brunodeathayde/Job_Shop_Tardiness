using JuMP,CPLEX

function MILP_Manne_tardiness(O,P,d,V,M,N,time_limit)
    model = Model(optimizer_with_attributes(CPLEX.Optimizer,"CPX_PARAM_TILIM" => time_limit, "CPX_PARAM_THREADS" => 1))

    # Decision variables
    @variable(model, x[j in 1:N, i in 1:M] >=0)
    @variable(model, z[j in 1:N-1, k in j+1:N, i in 1:M], Bin)
    @variable(model, C[j in 1:N] >=0)
    @variable(model, T[j in 1:N] >=0)

    # Objective function
    @objective(model, Min, sum(T[j] for j in 1:N))

    # Constraints
    @constraint(model, [j in 1:N, h in 2:M], x[j,O[j,h]] >= x[j,O[j,h-1]] + P[j,O[j,h-1]])
    @constraint(model, [j in 1:N-1, k in j+1:N, i in 1:M], x[j,i] >= x[k,i] + P[k,i] - V*z[j,k,i]) 
    @constraint(model, [j in 1:N-1, k in j+1:N, i in 1:M], x[k,i] >= x[j,i] + P[j,i] - V*(1 - z[j,k,i]))
    @constraint(model, [j in 1:N], C[j] >= x[j,O[j,M]] + P[j,O[j,M]])
    @constraint(model, [j in 1:N], T[j] >= C[j] - d[j])

    optimize!(model)


    if termination_status(model) == MOI.OPTIMAL
        zIP = objective_value(model)
        tzIP = MOI.get(model, MOI.SolveTimeSec())
        LRG = MOI.get(model, MOI.RelativeGap())
    elseif termination_status(model) == MOI.TIME_LIMIT && has_values(model)
        zIP = objective_value(model)
        tzIP = MOI.get(model, MOI.SolveTimeSec())
        LRG = MOI.get(model, MOI.RelativeGap())
    else
        zIP = -1
        tzIP = time_limit
        LRG = 100
    end
    return(zIP, tzIP, LRG)
 end