using JuMP,CPLEX

function MILP_Wagner_tardiness(O,P,d,M,N,time_limit)
    model = Model(optimizer_with_attributes(CPLEX.Optimizer,"CPX_PARAM_TILIM" => time_limit, "CPX_PARAM_THREADS" => 1))

    # Build matrix R[j,l,k] 
    R = zeros(Int64, N, N, M)

    for j in 1:N
        for i in 1:M
            maq = O[j,i]
            R[j,i,maq] = 1
        end
    end

    Cmax = job_shop_lpt(P,O)

    # Big-M Wagner
    V = Cmax + maximum(P) + 1


    # Decision variables
    @variable(model, x[j in 1:N, h in 1:N, i in 1:M], Bin)
    @variable(model, C[h in 1:N, i in 1:M] >=0)
    #@variable(model, C_[j in 1:N] >= 0)
    @variable(model, T[j in 1:N] >=0)

    # Objective function
    @objective(model, Min, sum(T[j] for j in 1:N)) 

    # Constraints
    @constraint(model, [j=1:N, k=1:M], sum(x[j,h,k] for h=1:N) == 1)
    @constraint(model, [h=1:N, k=1:M], sum(x[j,h,k] for j=1:N) == 1)
    @constraint(model, [k=1:M], C[1,k] == sum(P[j,k]*x[j,1,k] for j=1:N))
    @constraint(model, [h=2:N,k=1:M],C[h,k] >= C[h-1,k] + sum(P[j,k]*x[j,h,k] for j=1:N))

    @constraint(model, [j=1:N,h=1:N,hh=1:N,l=2:M], 
                sum(R[j,l,k]*C[h,k] for k=1:M) >= sum(R[j,l-1,k]*C[hh,k] for k=1:M) + 
                sum(R[j,l,k]*P[j,k] for k=1:M) - V*(2 - sum(R[j,l,k]*x[j,h,k] for k=1:M) - 
                sum(R[j,l-1,k]*x[j,hh,k] for k=1:M)))
                    
                        
    @constraint(model, [j in 1:N, h in 1:N], T[j] >= C[h,O[j,end]] - d[j] - sum(P) * (1 - x[j,h,O[j,end]]))

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


