clc;
I = imread('2.jpg');
block = legend(I);
imshow(block);
II=I;
I=rgb2gray(I);
% bgeb a3la height le Y Axis
res = ocr(I,'TextLayout','Block');
heights = str2double(regexp(res.Text, '\d+', 'match'));
Maxheights = max(heights);
Size=size(res.Words);
for i=1:Size(1)
 flagg=strcmp(res.Words(i),num2str(Maxheights));
   if flagg==1
     YAxis=res.WordBoundingBoxes(i,3);
     break;
   end
end
topColor=YAxis+15;
max_heights=Maxheights;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%preProcessing 

[h, w, ~] = size(II);
for i=1:h
    for j=1:w
        if ( II(i,j,1)<=150 && II(i,j,2)==255 && II(i,j,3)==255 ) 
             II(i,j,:)=255;
        end
    end
end
RedOne = II(:, :, 1);
GreenOne = II(:, :, 2);
BlueOne = II(:, :, 3);

r = medfilt2(RedOne, [12 12]);
g = medfilt2(GreenOne, [12 12]);
b = medfilt2(BlueOne, [12 12]);

II(:, :, 1)=r;
II(:, :, 2)=g;
II(:, :, 3)=b;
%%%%%%%%%%%%%%%%%%%%%%

x = rgb2gray(II);

BW = edge(x,'canny');
se = strel('sphere', 1);
BW = imdilate(BW,se);
BW = ~BW;
[L, num] = bwlabel(BW);
RGB = label2rgb(L);

[h, w, ~] = size(II);
smallRatio = h*w*0.002;
onecolor=[];

ColorPixels=0;
colordis=0;
distancecalc=0;
rgbPoint=[];
for i=1:num

    x = uint8(L==i);
    f = sum(sum(x==1));
    if(f < smallRatio)
        continue;
    end
    d = ones(size(II));
    d(:,:,1) = uint8(x).*II(:,:,1);
    d(:,:,2) = uint8(x).*II(:,:,2);
    d(:,:,3) = uint8(x).*II(:,:,3);
   
    whitePixel=Count_White_Pixels(d);

    if(whitePixel> 80 )
        continue;
    else
        colordis=0;
       
        [r g b]=GetRGB(d);
        rgbPoint=[rgbPoint,r g b];  
        imagee=rgb2gray(uint8(d));
        imagee=medfilt2(imagee,[4,4]);
        imagee=imsharpen(imagee,'Radius',5,'Amount',3);
    
         [distancecalc,colordis]=DistanceCalc(imagee);
         onecolor=[onecolor,colordis];
        
    end
   
end

Y=distancecalc-topColor;
output=[];
height=0;
[x,y]=size(onecolor);
    for i=1:y-1
         height=((onecolor(i)*max_heights)/Y);

         height=round(height);
         if (height<=max_heights)
             output=[output,height];
         end
    end
height=((onecolor(y)*max_heights)/Y);
height=floor(height);
output=[output,height];
output;
s=I;

 [rr, tt, ~] = size(block);
 rgbPoint=rgbPoint;
 ColorCounter=length(rgbPoint)/3;

 
rcount=1; gcount=2; bcount=3;

for zzz=1:ColorCounter
    qqq=0;
    blockk=block;
    for k =1: rr
        for p = 1 :tt 
            if blockk(k,p,1)>=rgbPoint(rcount)-15 && blockk(k,p,1)<=rgbPoint(rcount)+15 && blockk(k,p,2)>=rgbPoint(gcount)-15 && blockk(k,p,2)<=rgbPoint(gcount)+15 && blockk(k,p,3)>=rgbPoint(bcount)-15 && blockk(k,p,3)<=rgbPoint(bcount)+15 
                 cropp = imcrop(blockk,[p+10 k-5 100 28 ]);
                 figure;
                 imshow(cropp),title(output(zzz));
                 qqq=1;
                 break;

            end

        end
        if qqq==1
                break;
         end    
    end
rcount=rcount+3; gcount=gcount+3; bcount=bcount+3;  
end

