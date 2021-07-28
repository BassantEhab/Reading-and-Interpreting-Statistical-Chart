I = imread('1.png');

figure, imshow(I);
x = rgb2gray(I);
% x = medfilt2(x);
% x = im2double(x);
% x= imgaussfilt3 (x,4); 
BW = edge(x,'canny');
se = strel('square', 4);
BW = imdilate(BW,se);
BW = ~BW;
[L, num] = bwlabel(BW);
RGB = label2rgb(L);
c=0;
countAll=0;
[h, w, ~] = size(I);
smallRatio = h*w*0.002;
allColor=[];
for i=1:num
    x = uint8(L==i);
    f = sum(sum(x==1));
    if(f < smallRatio)
        continue;
    end
    
    d = zeros(size(I));
    d(:,:,1) = uint8(x).*I(:,:,1);
    d(:,:,2) = uint8(x).*I(:,:,2);
    d(:,:,3) = uint8(x).*I(:,:,3);

   d= uint8(d);
   
    
    [o, z, ~] = size(d);
%     figure,imshow(d);


whitePixel=0;
    for mm=1:o
        for nn=1:z
            if d(mm,nn,1)==255 && d(mm,nn,2)==255 && d(mm,nn,3)==255
                whitePixel=whitePixel+1;
            end

        end
    end
    c=0;
    if(whitePixel<80)

        d=imgaussfilt(d,3);
        d=imsharpen(d,'Radius',5,'Amount',1);
            for k=1:o
                for p =1:z
             if  (d(k,p,1)>0 || d(k,p,2)>0 || d(k,p,3)> 0)
                        countAll =countAll+1;
                        c=c+1;
                    end
                end
            end
            allColor=[allColor,c];

            
    end

end
allColor=(allColor/countAll)*100
% for i=1:num
%     x = uint8(L==i);
%     f = sum(sum(x==1));
%     if(f < smallRatio)
%         continue;
%     end
%     d = zeros(size(I));
%     d(:,:,1) = uint8(x).*I(:,:,1);
%     d(:,:,2) = uint8(x).*I(:,:,2);
%     d(:,:,3) = uint8(x).*I(:,:,3);
%    d= uint8(d);
%     if(whitePixel<80)
%         
%    
%     
%     
% c = 0;
% 
% [o, z, ~] = size(d);
%     for k=1:o
%         for p =1:z
%              if  d(k,p,1)> 0 && d(k,p,2)>= 0 && d(k,p,3)>= 0       
%         c =c+1;
%              end    
%              
%         end
%             figure,imshow(d),title((c/countAll)*100);
% 
%     end 
%     end
% 
% end