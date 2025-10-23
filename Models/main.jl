include("MILP_Liao_tardiness.jl")
include("MILP_Manne_tardiness.jl")
include("MILP_Kondili_tardiness.jl")
include("MILP_Wagner_tardiness.jl")
include("read_instance_new.jl")
include("job_shop_lpt.jl")

# Paths
input_path = ("/home/paulus/Dropbox/Pesquisa/Problemas/Job shop tardiness/Instances/New instances//")
output_path =("/home/paulus/Dropbox/Pesquisa/Problemas/Job shop tardiness/Results/Results_MILP/Prata/")
                      

# Number of test instances
num_instances = 60

println("The MILP model is starting!")

for k = 1:num_instances    
    filename = string(input_path,"P",k,".txt")    
    # Parameters
    M,N,P,O,R,d = read_instance(filename) 

    # Big-M (Manne and Liao)
    V = sum(P)

    # Time limit
    time_limit = 3600

    # Running MILP
    zIP,tzIP,LRG = MILP_Manne_tardiness(O,P,d,V,M,N,time_limit)
    
    # Saving results
    file_name = string(output_path,"results_", k, ".txt")
    results = open(file_name, "w")
    println(results,zIP,"   ",tzIP,"   ",LRG)
    println(zIP,"   ",tzIP,"   ",LRG)
    close(results)
end

println("The MILP model was successfully run!")







