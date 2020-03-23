function echelon_solver(in_matrix)
    x,y=size(in_matrix)
    mate=convert(Matrix{Float64},in_matrix)
  
    side=0
   if y>x
        side=x
    else
        side=y-1
    end
        
        meat=mate[1:x,1:y-1]
        m=meat[:]
        a=m[m.!=0]
    
    while length(a)>side
        
    for i::Int in 1:side
            
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
        
       mate[i,:]=round(mate[i,:]/mate[i,i],9)
        for k::Int in 1:x
                if  k!=i
            if mate[k,i]!=0
                    mate[k,:]-=mate[i,:]*round(mate[k,i]/mate[i,i],9)
                end
        end
        end
    end   
        
        if y>x+1
            meat=mate[1:x,1:x]
        else
            meat=mate[1:x,1:y-1]
        end
        m=meat[:]
        a=m[m.!=0,]
    
    end
        
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

