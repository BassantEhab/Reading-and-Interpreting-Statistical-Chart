function [ count ] = CountOneImagePixels( d )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[o, z, ~] = size(d);
count=0;

    for k=1:o
        for p =1:z
             if  ~(d(k,p,1)>= 255 && d(k,p,2)>= 255 && d(k,p,3)>= 255) && ~(d(k,p,1)== 0 && d(k,p,2)== 0 && d(k,p,3)== 0)
                count =count+1;  
            end
        end
        
        
    end
end

