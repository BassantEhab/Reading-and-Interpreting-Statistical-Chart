function [ r,g,b ] = GetRGB( d )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[o, z, ~] = size(d);
qq=0;
r=0;g=0;b=0;
    for k=1:o
        for p =1:z
             if  ~(d(k,p,1)>= 255 && d(k,p,2)>= 255 && d(k,p,3)>= 255) && ~(d(k,p,1)== 0 && d(k,p,2)== 0 && d(k,p,3)== 0)
                r = d(k,p,1);
                g = d(k,p,2);
                b = d(k,p,3);
                qq=1;
                break;
            end
        end
        if qq==1
            break;
        end
    end

end

