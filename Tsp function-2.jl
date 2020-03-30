##This function solves a distance matrix for the traveling salesman problem.  This is useful to find the shortest path
##between a set of points having to travel through all of the points before returning to the original position.

function b_and_b_tsp(matrix)
    matrix=convert(Matrix{Float64},matrix)
    b::Int=sqrt(length(matrix))
    
    ##This is the upper bound for the problem.  This is a minimization problem so the minimum objective value 
    ##needs to be found.  If we were maximizing then we would use a lower bound first=[-Inf,-Inf,-Inf,-Inf].
    first=[Inf;Inf;Inf;Inf]
    ##This is the objective value to be returned after the shortest path is found.
    n_for_return=0  
 
    ##The loop starts at two becaus the first point in the list is the beginning point.  The loop also starts at 2
    ##because in a distance matrix the nodes cannot visit each other.  The diagonal is all zeros.
    for i::Int in 2:b
        
        
nodes=[]
t=[]
a=i
push!(nodes,1)
push!(nodes,i)
push!(t,matrix[1,i])

for j::Int in 2:b
    
    
   ##When all the nodes are visited.
    if length(nodes)==b
        break
    end
            
    ##The minimum of each row is found based off of the node visited, finding the shortest path between nodes
    ##that have not yet been visited.  The "need" variable is needed to find the first occurence of the minimum
    ##value from the present node.  This creates an array to choose from as long as the node isn't previously 
    ##visited it will be used.  
    d=minimum(matrix[a,k] for k::Int in 1:b if k ∉ nodes && k!=i)
    need=findall(isequal(d),matrix[a,:])
                push!(t,d)
                        
                for l::Int in 1:length(need)
                    if need[l] ∉ nodes
                push!(nodes,need[l])
                        a=need[l]
                    break
                    end
                end
                
            end
            
                
                    push!(nodes,1)
                    last=nodes[b]
                    nay=matrix[last,1]
                    push!(t,nay)
                
                    if sum(t)<sum(first)
                        first=t
                        n_for_return=nodes
                        end
                end
            z_return=sum(first)
                
                
                return n_for_return,  z_return   
        
            end
##Sample distance matrix created with random points from a previously defined function.
dist=[ 0.0     17.4642   20.6155   10.0499   20.8806 ;
      17.4642   0.0       3.16228   8.48528   4.12311;
      20.6155   3.16228   0.0      11.4018    2.23607;
      10.0499   8.48528  11.4018    0.0      11.1803; 
      20.8806   4.12311   2.23607  11.1803    0.0]

##The function is called returning the order of the nodes visited and the objective value.
sol,z=b_and_b_tsp(dist)

##Returned nodes and objective value.
(Any[1, 2, 3, 5, 4, 1], 44.09275)
 
            
##The results above will be proven correct using JuMP. Constraints are:
##One node from each column must be chosen
##One node from each row must be chosen
##The diagonal must be zero because the nodes cannot visit themselves
##Each node can be visited only once
using Pkg
Pkg.add("JuMP")
Pkg.add("GLPK")
using JuMP
using GLPK

a=Model(with_optimizer(GLPK.Optimizer))

@variable(a,graph[1:5,1:5]>=0)

@constraint(a,[i in 1:5],sum(graph[i,j] for j in 1:5)==1)

@constraint(a,[i in 1:5],sum(graph[j,i] for j in 1:5)==1)

@constraint(a,[i in 1:5,j in 1:3],graph[i,j]+graph[j,i]<=1)

@constraint(a,[i in 1:5],graph[i,i]==0)

@objective(a,Min,sum(graph[i,j]*dist[i,j] for i in 1:5,j in 1:5))

optimize!(a)

##Matrix chosen to minimize path
value.(graph)
            
 0.0  1.0  0.0  0.0  0.0
 0.0  0.0  1.0  0.0  0.0
 0.0  0.0  0.0  0.0  1.0
 1.0  0.0  0.0  0.0  0.0
 0.0  0.0  0.0  1.0  0.0
            
objective_value(a)
            
44.09275
            
##The objective value is the same as the above function verifying results.
