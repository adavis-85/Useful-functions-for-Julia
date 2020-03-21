##Show the distance between points which are cartesian but could also be 
##latitude and longitude though function would need to be altered.

function hypotenuse(x)
    
       right=(x[1][1]-x[2][1])^2
       left=(x[1][2]-x[2][2])^2
       return(sqrt(right+left))
       end

##Takes in a list of points starting at whichever is desired.  For demonstration purposes
##the beginning point is at the origin (0,0).  Then calculates the distance from each individual
##point to all others 
##for example for three points:
## 0->1
## 0->2
## 0->3
##would be the first row with the row beginning at the distance of the point to itself 
##which would be zero.

function distance_matrix(list)
              new=Tuple{Int,Int}[]
              push!(new,(0,0))
              for i in 1:length(list)
              push!(new,(list[i]))
              end
               list=new
              n=length(list)
              mat=zeros(n,n)
              for i in 1:n
              for j in 1:n
              t=(list[i],list[j])
              mat[i,j]=hypotenuse(t)
              end
              end
              return mat
              end

first_point=rand(1:10,4)
second_point=rand(1:10,4)
point_list=Tuple{Int,Int}[]

for i in 1:length(first_point)
    push!(point_list,(first_point[i],second_point[i]))
end

##Point list
point_list

 (7, 5) 
 (8, 7) 
 (3, 10)
 (6, 1) 
##Now the matrix with the starting location being the origin.
Distances=distance_matrix(point_list)

  0.0      8.60233  10.6301   10.4403   6.08276
  8.60233  0.0       2.23607   6.40312  4.12311
 10.6301   2.23607   0.0       5.83095  6.32456
 10.4403   6.40312   5.83095   0.0      9.48683
  6.08276  4.12311   6.32456   9.48683  0.0  



