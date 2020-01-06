##A function to make a block circulant matrix from a three-dimensional tensor

function BCM(A)
    a,b,c=size(A)
    thematrix=Matrix{Float64}(undef,a*c,b*c)
    
    j=1
    jump=a
    
    ##First column of the ac,bc matrix is the block array form of the tensor.  
    ##There is a separate function for this by itself
    
    for i=1:c
     thematrix[j:jump,1:b]=A[:,:,i]
        j=j+a
        jump=jump+a
    end
    
    ##Incrementing the circular shift for the prescribed width of the columns
    
    jump=b+1
    i=1
    for j=2:c
        thematrix[:,jump:b*j]=circshift(thematrix[:,1:b],a*i)
        jump=jump+b
        i=i+1
    end
    return thematrix
end


##To test the accuracy we specify a small enough tensor.
t=rand(1:3,3,3,3)

q=BCM(t)


