function [ out ] = ColorDis( imagee )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[h, w, ~] = size(imagee);
colorbetween=0;
        q=0;
         for i=1:h
            for j=1:w
                if imagee(i,j,:) ~= 0
                     colorbetween=i;
                     q=1;
                     break;
                end
            end
            if q==1
                break;
            end
         end
         out=colorbetween;

end

