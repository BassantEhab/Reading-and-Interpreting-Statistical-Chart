function [ whitePixell ] = Count_White_Pixels( d )
whitePixel=0;
[o, z, ~] = size(d);
for mm=1:o
        for nn=1:z
            if d(mm,nn,1)==255 && d(mm,nn,2)==255 && d(mm,nn,3)==255
                whitePixel=whitePixel+1;
            end

        end
end
whitePixell=whitePixel;
end

