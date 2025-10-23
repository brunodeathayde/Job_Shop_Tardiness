using DelimitedFiles
function read_instance(file_name)
    file = open(file_name,"r")
    # Reading M and N
    line1 = readline(file)
    line1 = split(line1, "	");
    M=parse(Int16,line1[1])
    N=parse(Int16,line1[2])

    # Memory allocation
    P = zeros(Int16, N, M)
    O = zeros(Int16, N, M)
    R = zeros(Int16, N, M)
    d = zeros(Int64, N)

    # Reading processing times
    line1 = readline(file)
    for j in 1:N
        lineM = readline(file)
        lineM = split(lineM, "\t")
        for i in 1:lastindex(lineM)
            P[j,i]=parse(Int16,lineM[i])
        end
    end

    # Reading routes
    line1 = readline(file)
    for j in 1:N
        lineM = readline(file)
        lineM = split(lineM, "\t")
        for i in 1:lastindex(lineM)
            O[j,i]=parse(Int16,lineM[i])
        end
    end

    # Reading due dates
    line1 = readline(file)
    for j in 1:N
        lineM = readline(file)
        lineM = split(lineM, "\t")  
        d[j]=parse(Int16,lineM[1])
    end

    
    close(file)
    return(M,N,P,O,R,d)
end