##The matrix needs to be a matrix of any size with the b column attached .  This function uses that information to solve 
##for the variables.


function echelon_solver(in_matrix)
    x,y=size(in_matrix)
    ##It is essential to have the matrix of the right type for the processes that will be done.  Here it is converted.
    mate=convert(Matrix{Float64},in_matrix)
  
    ##The side variable is to represent the number of times the row reduced funciton if performed for the matrix.
    ##For example in a 2x3 matrix there would be two x values so the process would be performed 2 times.
    ##For a 2x5 the process would still be performed 2 times but would have to stop after those two times.  
    ##Also for any n x m matrix where n is greater than or equal to m the process would be performed a specific amount 
    ##of times depending on the size of the matrix.  The following section takes care of that.  
    side=0
   if y>x
        side=x
    else
        side=y-1
    end
       
    ##The following section is part of the stopping condition calculations for the while loop.  The "a" variable saves 
    ##the amount of variables that aren't zero.  As long as the length of a is greater than the side variable the 
    ##loop keeps iterating until solved based on the conditions.
        meat=mate[1:x,1:y-1]
        m=meat[:]
        a=m[m.!=0]
    
    while length(a)>side
        
    for i::Int in 1:side
            
     ##This section solves the problem of a number being in the i,i position being a zero.  The next closes number will 
     ##then be selected and the rows of each will be swapped.  
        if mate[i,i]==0
        for j::Int in 1:x
            if mate[j,i]!=0
                see=j
                swap=mate[see,:]
                mate[j,:]=mate[i,:]
                mate[i,:]=swap
                break
                end
            end
        end
        
            ##Rounding in the case of floating point numbers of any value.
       mate[i,:]=round(mate[i,:]/mate[i,i],9)
        for k::Int in 1:x
                if  k!=i
            if mate[k,i]!=0
                    mate[k,:]-=mate[i,:]*round(mate[k,i]/mate[i,i],9)
                end
        end
        end
    end   
        ##Affecting the stopping conditions.
        if y>x+1
            meat=mate[1:x,1:x]
        else
            meat=mate[1:x,1:y-1]
        end
        m=meat[:]
        a=m[m.!=0,]
    
    end
        
    ##Results desired are the solved matrix and the x values in array form.
   c=0
    if x>=y
    c=mate[:,y]
    c[side+1:x] .=0
    else
       c=mate[:,y]
        c=vcat(c,zeros((y-1)-x))
    end
    
    
  return meat,c
    
end

    


matrix=rand(1:11,2,4)

 6   1  6  10
 6  11  8   4

a,b=echelon_solver(matrix)

a
1.0  0.0
0.0  1.0

b
1.76667
 -0.6    
  0.0 

matrix=rand(-2:10,5,3)
 9   9   8
 9   8   5
 7   7  10
 5   9   7
-1  -2   6

a,b=echelon_solver(matrix)

a
  1.0  0.0
 -0.0  1.0
  0.0  0.0
  0.0  0.0
  0.0  0.0

b
 -2.11111
  3.0    
  0.0    
  0.0    
  0.0 

