function [ out ,colorbetween ] = DistanceCalc( imagee )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

 [h, w, ~] = size(imagee);
 q=0;
 out=0;
 colorbetween=ColorDis(imagee);
          for i=h:-1:1
            for j=w:-1:1
                
                if imagee(i,j,:) ~= 0
                    out=i;
                    q=1;
                    colorbetween=i-colorbetween;
                    break;
                  
                end
            end
            if q ==1
                break;
            end
         end

end

