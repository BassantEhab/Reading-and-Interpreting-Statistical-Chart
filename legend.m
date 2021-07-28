    function [ legended ] = legend( I )

gray=rgb2gray(I);
boxMask = gray < 25;
boxMask = imclearborder(~boxMask);
boxMask = bwareafilt(boxMask, 1);
boxMask = imfill(boxMask, 'holes');
props = regionprops(boxMask, 'BoundingBox')
croppedImage = imcrop(I, props.BoundingBox);
legended=croppedImage;

[h w ~]=size(croppedImage);
if(h==0)
gray=rgb2gray(I);

    boxMask =gray < 160;
    boxMask = imclearborder(~boxMask);
    boxMask = bwareafilt(boxMask, 1);
    boxMask = imfill(boxMask, 'holes');
    props = regionprops(boxMask, 'BoundingBox')
    croppedImage = imcrop(I, props.BoundingBox);
    legended=croppedImage;


    
end






end

