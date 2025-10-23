function job_shop_lpt(P,O)
    num_jobs = size(P, 1)
    num_machines = maximum(O)  
    
    machine_schedules = Dict{Int, Vector{Tuple{Int, Int, Int}}}()  # máquina => [(job, start_time, duration)]
    job_completion_times = zeros(Int, num_jobs)
    machine_available = zeros(Int, num_machines)
    
    operations = []
    for job in 1:num_jobs
        for op in 1:size(P, 2)
            machine = O[job, op]
            duration = P[job, op]
            push!(operations, (job, machine, duration, op))
        end
    end
    
    sorted_ops = sort(operations, by=x->x[3], rev=true)
    
    for op in sorted_ops
        job, machine, duration, op_num = op
        start_time = max(job_completion_times[job], machine_available[machine])
        
        if !haskey(machine_schedules, machine)
            machine_schedules[machine] = []
        end
        push!(machine_schedules[machine], (job, start_time, duration))
        
        completion_time = start_time + duration
        job_completion_times[job] = completion_time
        machine_available[machine] = completion_time
    end    
    makespan = maximum(job_completion_times)
    
    return(makespan)
end




