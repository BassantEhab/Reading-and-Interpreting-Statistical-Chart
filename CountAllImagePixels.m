function [ countall ] = CountAllImagePixels( d )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[o, z, ~] = size(d);
countall=0;

    for k=1:o
        for p =1:z
             if  ~(d(k,p,1)>= 255 && d(k,p,2)>= 255 && d(k,p,3)>= 255) && ~(d(k,p,1)== 0 && d(k,p,2)== 0 && d(k,p,3)== 0)
                countall =countall+1;  
            end
        end
        
        
    end
end

