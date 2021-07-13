I = imread('1.png');
gray=rgb2gray(I);
BW = edge(gray,'canny');
se = strel('square', 5);
BW = imdilate(BW,se);
BW = ~BW;
[L, num] = bwlabel(BW);
RGB = label2rgb(L);

[h, w, ~] = size(I);
smallRatio = h*w*0.002;
for i=3:num
    x = uint8(L==i);
    f = sum(sum(x==1));
    if(f < smallRatio)
        continue;
    end
    d = zeros(size(I));
    d(:,:,1) = uint8(x).*I(:,:,1);
    d(:,:,2) = uint8(x).*I(:,:,2);
    d(:,:,3) = uint8(x).*I(:,:,3);
    q=~imbinarize(rgb2gray(d));
    q = label2rgb(q);

    figure,imshow(uint8(q));

end

