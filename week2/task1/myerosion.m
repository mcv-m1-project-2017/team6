function [myErodedImg]=myerosion(image,se)
%{
Juan Felipe Montesinos
Yi Xiao
Ferran Carrasquer Mas
Master in Computer Vision
Computer Vision Center, Barcelona
---------------------------
Project M1/Block2
---------------------------
This function is used to implement morphological operators erosion on
images
input: - image: the original image to be eroded
       - se: the structuring element you used for the erosion
output:- myErodedImg: the output image after we use the Erosion operator
---------------------------
%}

%get the center point of the structuring element.
half_H = floor(size(se,1)/2);
half_W = floor(size(se,2)/2);
%Pad zeros on all the sides.
padImage=padarray(image,[half_H,half_W],'replicate');
[r,c]=size(padImage);
myErodedImg = zeros(size(padImage));

%use the structuring element to scan the whole image, then find the minimum
%pixel value in this area and put it into the center point of the output
%image
for i=(1+half_H):(r-half_H)
    for j=(1+half_W):(c-half_W)
        myErodedImg(i,j)=min(min(se&padImage(i-half_H:i+half_H,j-half_W:j+half_W)));
    end
end
myErodedImg = myErodedImg(1+half_H:r-half_H,1+half_W:c-half_W);
end