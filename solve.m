I = imread('1.png');
block = legend(I);
% figure,imshow(I);
gray=rgb2gray(I);
BW = edge(gray,'canny');
se = strel('square', 8);
BW = imdilate(BW,se);
BW = ~BW;
[L, num] = bwlabel(BW);

RGB = label2rgb(L);
%     figure,imshow(RGB);
[H, W, ~] = size(I);
smallRatio = H*W*0.002;
allColor=[];
carray=[];
countAll = 0;

rgbPoint=[];
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
    
  whitePixel=Count_White_Pixels(d);
if(whitePixel<80)
    

        [r g b]=GetRGB(d);
        rgbPoint=[rgbPoint, r g b];
        d=imgaussfilt(d,3);
        d=imsharpen(d,'Radius',5,'Amount',1);

    
    c=CountOneImagePixels(d); 
    countAll=countAll+CountAllImagePixels(d);
     allColor=[allColor,c];
     
    
end
        
  end


 allColor=(allColor/countAll)*100
 rgbPoint


 [rr, tt, ~] = size(block);
ColorCounter=length(rgbPoint)/3;

 
rcount=1;
gcount=2;
bcount=3;
    
for zzz=1:ColorCounter
    qqq=0;
    blockk=block;
    for k =1: rr
        for p = 1 :tt 
            if blockk(k,p,1)>=rgbPoint(rcount)-10 && blockk(k,p,1)<=rgbPoint(rcount)+10 && blockk(k,p,2)>=rgbPoint(gcount)-10 && blockk(k,p,2)<=rgbPoint(gcount)+10 && blockk(k,p,3)>=rgbPoint(bcount)-10 && blockk(k,p,3)<=rgbPoint(bcount)+10 
                 cropp = imcrop(blockk,[p+10 k-5 100 28 ]);
                 figure;

                 imshow(cropp),title(allColor(zzz));

                 
                 qqq=1;
                 break;

            end

        end
        if qqq==1
                break;
         end    
    end
rcount=rcount+3;
gcount=gcount+3;
bcount=bcount+3;  
end


    
% [rr, tt, ~] = size(block);
% 
% ColorCounter=length(rgbPoint)/3;
% rcount=1;
% gcount=2;
% bcount=3;
% 
% 
% for zzz=1:ColorCounter
%     blockk=block;
%     qqq=0;
%     for k=1:tt
%         for p =1:rr
%             if blockk(k,p,1)>=rgbPoint(rcount)-10 && blockk(k,p,1)<=rgbPoint(rcount)+10 && blockk(k,p,2)>=rgbPoint(gcount)-10 && blockk(k,p,2)<=rgbPoint(gcount)+10 && blockk(k,p,3)>=rgbPoint(bcount)-10 && blockk(k,p,3)<=rgbPoint(bcount)+10 
%                 cropp = imcrop(blockk,[p+10 k-5 100 28 ]);
%                 subplot(1,2,1);
%                 imshow(cropp),title("cropped img");
%                 subplot(1,2,2);
%                 imshow(d),title(allColor(zzz));
%                 figure;
%                 qqq=1;
%                 break;
%             end 
%     
%               break
%         end
%              if qqq==1
%               break;
% 
%         end
%         
%         
%    
%     end
%     rcount=rcount+3;
%     gcount=gcount+3;
%     bcount=bcount+3;
%     
% end

  
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
%     
%   
%    
%     
%     
% c = 0;
% % r = 0;
% % b = 0;
% % g = 0;
% [o, z, ~] = size(d);
% % check = 0;
%   d=imgaussfilt(d,4);
%   d=imsharpen(d,'Radius',5,'Amount',1);
%     for k=1:o
%         for p =1:z
%              if  ~(d(k,p,1)>= 220 && d(k,p,2)>= 220 && d(k,p,3)>= 220) && ~(d(k,p,1)== 0 && d(k,p,2)== 0 && d(k,p,3)== 0)
%                 c =c+1;
% %                 check = check +1;
% %                 if check == 5
% %                     r = d(k,p,1);
% %                     g = d(k,p,2);
% %                     b = d(k,p,3);
% % %                     check =0;
% %                 end
%              end    
% %             disp(k+" "+p)
%         end
%     end 
% %     figure,imshow(d),title((c/countAll)*100);
%     [o, z, ~] = size(block);
%     check = 0;
%     for k=1:o
%         for p =1:z
%             if (check==0 && block(k,p,1) >=r-2&& block(k,p,2) >= g-2 && block(k,p,3) >= b-2 && block(k,p,1) <=r+2&& block(k,p,2) <= g+2 && block(k,p,3) <= b+2)
%                 cropp = imcrop(block,[k+10 p+5 50 10 ]);
%                 subplot(1,2,1);
%                 imshow(cropp),title("cropped img");
%                 check = 1;
%                 subplot(1,2,2);
%                 imshow(d),title((c/countAll)*100);
%                 figure;
%             end   
%         end
%     end
% end  
% 
% end
% countAll